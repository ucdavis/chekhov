class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  respond_to :json
  filter_access_to :all, :attribute_check => true
  filter_access_to :create, :attribute_check => false
  filter_access_to :index, :attribute_check => true, :load_method => :load_checklists
  wrap_parameters :checklist, include: [:template_id, :name, :public, :entries_attributes, :user_id]

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
      params.require(:checklist).permit(:template_id, :name, :public, :user_id, :started, :finished, entries_attributes: [:id, :content, :position, :user_id, :checked])
    end

    def load_checklists
      @checklists = Checklist.with_permissions_to(:read).where(:finished => nil)
    end
end
