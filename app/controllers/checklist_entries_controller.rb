class ChecklistEntriesController < ApplicationController
  before_action :set_checklist_entry, only: [:show, :edit, :update, :destroy]
  respond_to :json
  filter_resource_access

  def index
    @checklist_entries = ChecklistEntry.all
  end

  def show
  end

  def new
    @checklist_entry = ChecklistEntry.new
  end

  def edit
  end

  def create
    @checklist_entry = ChecklistEntry.new(checklist_entry_params)

    flash[:notice] = "Checklst entry was successfully created." if @checklist_entry.save

    respond_with(@checklist_entry) do |format|
      format.json { render }
    end
  end

  def update
    flash[:notice] = "Checklst entry was successfully updated." if @checklist_entry.update(checklist_entry_params)
    
    respond_with(@checklist_entry) do |format|
      format.json { head :no_content }
    end
  end

  def destroy
    @checklist_entry.destroy
    
    respond_with(@checklist_entry) do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist_entry
      @checklist_entry = ChecklistEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_entry_params
      params.require(:checklist_entry).permit(:checklist_id, :template_entry_id, :user_id)
    end
end
