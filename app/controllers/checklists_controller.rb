class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  respond_to :json
  filter_resource_access

  def index
    @checklists = Checklist.all
  end

  def show
  end

  def new
    @checklist = Checklist.new
  end

  def edit
  end

  def create
    @checklist = Checklist.new(checklist_params)
    
    flash[:notice] = "Checklist was successfully created." if @checklist.save
    
    respond_with(@checklist)
  end

  def update
    flash[:notice] = "Checklist was successfully updated." if @checklist.update(checklist_params)
    
    respond_with @checklist
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
      params.require(:checklist).permit(:template_id, :public, :user_id, :started, :finished)
    end
end
