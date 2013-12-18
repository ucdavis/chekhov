class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  respond_to :json
  filter_access_to :all, :attribute_check => true
  filter_access_to :create, :attribute_check => false
  filter_access_to :index, :attribute_check => true, :load_method => :load_checklists
  wrap_parameters :checklist, include: [:template_name, :name, :public, :entries_attributes]

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
    flash[:notice] = "Checklist was successfully updated." if @checklist.update(checklist_params)
    
    respond_to do |format|
      format.json { render :show }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_params
      params[:checklist][:entries_attributes].each do |e|
        # If saving a checked item with no author, it's implied the current_user
        # is checking the box.
        if e[:checked] and e[:user_id].nil?
          e[:user_id] = Authorization.current_user[:id]
        end
      end if params[:checklist][:entries_attributes]

      params.require(:checklist).permit(:template_name, :name, :public, :user_id, :started, :finished, entries_attributes: [:id, :content, :position, :user_id, :checked])
    end

    def load_checklists
      @checklists = Checklist.with_permissions_to(:read).joins(:entries).where(checklist_entries: {checked: false}).uniq
      # Archived checklists are the inverse of the above line, so:
      # ([-1, @checklists.pluck(:id)].flatten] is dirty but ActiveRecord translates an empty array into NULL which results in there being no results if there are no open checklists)
      @checklists = Checklist.with_permissions_to(:read).where("id NOT IN (?)", [-1, @checklists.pluck(:id)].flatten) if params[:archived] == 'true'
    end
end
