class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  respond_to :json
  filter_access_to :all, :attribute_check => true
  filter_access_to :create, :attribute_check => false
  filter_access_to :index, :attribute_check => true, :load_method => :load_templates
  wrap_parameters :template, include: [:owner_id, :name, :checklist_count, :entries_attributes, :desc, :template_category]

  def index
  # @templates = Template.order(checklist_count: :desc)
    @template_count = Template.count
    @archived_count = Checklist.where("finished is not null").count
    @active_count = Checklist.where("finished is null").count

    if params[:query]
      @is_search = true
      @templates = Template.with_permissions_to(:read).where("lower(name) like ?", "%#{params[:query]}%").reorder(name: :asc)
    end

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
      if ! params[:template][:template_category].blank? && ! params[:template][:template_category][:name].blank?
        params[:template][:template_category] =
          TemplateCategory.find_or_create_by(name: params[:template][:template_category][:name])
      else
        params[:template][:template_category] = nil
      end

      params[:template][:owner_id] = Authorization.current_user[:id]
      template = params.require(:template).permit(:owner_id, :name, :desc, :checklist_count, entries_attributes: [:id, :content, :position, :_destroy])
      template.store(:template_category, params[:template][:template_category])

      return template
    end

    def load_templates
      templates = Template.with_permissions_to(:read).all

      if params[:categories] && params[:categories].count > 0
        templates = templates.includes(:entries).where('template_category_id in (?)', params[:categories])
      end

      @templates = templates.includes(:entries).order(updated_at: :desc).uniq
    end
end
