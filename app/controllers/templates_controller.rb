class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  respond_to :json
  filter_access_to :all, :attribute_check => true
  filter_access_to :create, :attribute_check => false
  filter_access_to :index, :attribute_check => true, :load_method => :load_templates
  wrap_parameters :template, include: [:owner_id, :name, :entries_attributes]
  
  def index
    @templates = Template.all
    
    respond_with(@templates) do |format|
      format.json
      format.html
    end
  end

  def show
  end

  def new
    @template = Template.new
  end

  def edit
  end

  def create
    @template = Template.new(template_params)
    
    flash[:notice] = 'Template was successfully created.' if @template.save

    respond_with(@template)
  end

  def update
    flash[:notice] = 'Template was successfully updated.' if @template.update(template_params)
    
    respond_with(@template)
  end

  def destroy
    @template.destroy

    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params[:template][:owner_id] = Authorization.current_user[:id]
      params.require(:template).permit(:owner_id, :name, entries_attributes: [:id, :content, :position, :_destroy])
    end

    def load_templates
      @templates = Template.with_permissions_to(:read).all
    end
end
