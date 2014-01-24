class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  respond_to :json
  filter_access_to :all, :attribute_check => true
  filter_access_to :create, :attribute_check => false
  filter_access_to :index, :attribute_check => true, :load_method => :load_checklists
  wrap_parameters :checklist, include: [:template_name, :name, :public, :entries_attributes, :ticket_number, :finished, :comments_attributes]

  def index
  end

  def show
  end

  def new
    @checklist = Checklist.new
  end

  def edit
  end

  def create
    params[:checklist][:user_id] = Authorization.current_user[:id]

    @checklist = Checklist.new(checklist_params)

    @template = Template.find_by_id(params[:template_id])
  
    if @template
      @checklist.template_name = @template.name
    end
    
    if @checklist.save
      flash[:notice] = "Checklist was successfully created."
      
      # Copy template_entries into checklist
      Checklist.transaction do
        @template.entries.each do |template_entry|
          @checklist.entries << ChecklistEntry.create!({ position: template_entry.position, content: template_entry.content, checklist_id: @checklist.id })
        end
      end
    end
    
    respond_with(@checklist)
  end

  def update
    # Set the finished time value only if all entries are checked 
    unchecked_entries = params[:checklist][:entries_attributes].select {|e| e['checked'] == false}
    if unchecked_entries.length == 0
      params[:checklist][:finished] = Time.now
    else
      params[:checklist][:finished] = nil
    end
    
    begin
      update_sysaid_activities(params)
      update_sysaid_notes(params)
      
      flash[:notice] = "Checklist was successfully updated." if @checklist.update(checklist_params)

      respond_to do |format|
        format.json { render :show }
      end
    rescue SysAidError => e
      flash[:notice] = "Could not update checklist: #{e}."
      
      respond_to do |format|
        format.json { render :json => {:errors => {:SysAid => ["#{e}"]}}, status: 422 }
      end
    end
  end

  def destroy
    @checklist.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist
      @checklist = Checklist.find(params[:id])
    end
    
    def update_sysaid_notes(params)
      # Checklist comments should be saved to SysAid's 'Notes' section (if a SysAid ticket number is provided)
      params[:checklist][:comments_attributes].each do |c|
        # New comments will have no author. Set to current_user and
        # sync only the new comment with SysAid (if ticket number is available)
        if c[:id].nil?
          c[:author] = Authorization.current_user[:name]
          
          unless params[:checklist][:ticket_number].blank?
            ticket = SysAid::Ticket.find_by_id params[:checklist][:ticket_number]

            if ticket
              ticket.add_note c[:author], c[:content]
              unless ticket.save
                raise SysAidError, "Failed to save new comment to SysAid"
              end
            else
              raise SysAidError, "No ticket matches the provided ticket number"
            end

          end
        end
      end if params[:checklist][:comments_attributes]
      
      # A permalink to the checklist should be added to SysAid's 'Notes' section whenever the ticket_number is set or changed.
      if @checklist.ticket_number != params[:checklist][:ticket_number]
        ticket = SysAid::Ticket.find_by_id params[:checklist][:ticket_number]
        ticket.add_note current_user.name, "The checklist for this ticket can be found at #{root_url}templates#/checklists/#{@checklist.id}"
        raise SysAidError, "Failed to save new note to SysAid" unless ticket.save
      end
    end
    
    # Creates SysAid activities for newly checked items only if a SysAid ticket number is set
    def update_sysaid_activities(params)
      return unless params[:checklist][:ticket_number]
      
      ticket_id = params[:checklist][:ticket_number].to_i
      
      params[:checklist][:entries_attributes].each do |e|
        # If saving a checked item with no author, it's implied the current_user
        # is checking the box.
        if e[:checked] and e[:completed_by].nil?
          e[:completed_by] = User.find(Authorization.current_user[:id]).name
          e[:finished] = Time.now
          
          # Log this 'checking' in SysAid
          unless params[:checklist][:ticket_number].blank?
            activity = SysAid::Activity.new
            activity.description = e[:content]
            activity.sr_id = ticket_id
            activity.to_time = DateTime.now
            activity.from_time = DateTime.now - (e[:time_spent].to_i).minutes
            activity.user = current_user.loginid
            
            raise SysAidError, "Failed to save new activity to SysAid" unless activity.save
          end
        end
      end if params[:checklist][:entries_attributes]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_params
      params.require(:checklist).permit(:template_name, :name, :public, :user_id, :started, :finished, :ticket_number, entries_attributes: [:id, :content, :position, :checked, :finished, :completed_by], comments_attributes: [:id, :content, :author])
    end

    def load_checklists
      @checklists = Checklist.with_permissions_to(:read).joins(:entries).where("checklists.finished is null").order(updated_at: :desc).uniq
      # Archived checklists are the inverse of the above line, so:
      # ([-1, @checklists.pluck(:id)].flatten] is dirty but ActiveRecord translates an empty array into NULL which results in there being no results if there are no open checklists)
      @checklists = Checklist.with_permissions_to(:read).where("checklists.finished is not null") if params[:archived] == 'true'
    end
end
