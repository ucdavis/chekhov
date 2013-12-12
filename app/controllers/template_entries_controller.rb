class TemplateEntriesController < ApplicationController
  before_action :set_template_entry, only: [:show, :edit, :update, :destroy]
  respond_with :json
  filter_resource_access

  def index
    @template_entries = TemplateEntry.all
  end

  def show
  end

  def new
    @template_entry = TemplateEntry.new
  end

  def edit
  end

  def create
    @template_entry = TemplateEntry.new(template_entry_params)
    
    flash[:notice] = "Template entry was successfully created." if @template_entry.save

    respond_with(@template_entry)
  end

  def update
    flash[:notice] = "Template entry was successfully updated." if @template_entry.update(template_entry_params)

    respond_with @template_entry
  end

  def destroy
    @template_entry.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template_entry
      @template_entry = TemplateEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_entry_params
      params.require(:template_entry).permit(:template_id, :content, :position)
    end
end
