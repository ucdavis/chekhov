class ChecklistCategoriesController < ApplicationController
  respond_to :json
  before_action :set_checklist_category, only: [:show, :edit, :update, :destroy]
  filter_access_to :all
  wrap_parameters :checklist_category, include: [:name, :id ]

  # GET /checklist_categories
  # GET /checklist_categories.json
  # Only display categories that actually have checklists. Categories don't
  # actually get deleted from the list, but they "disappear" when there's no
  # checklists in a given category (giving the illusion that the category
  # doesn't exist).
  def index
    @checklist_categories = ChecklistCategory.joins(:checklists).group('checklist_categories.id').having('count(checklists.id) > 0')
  end

  # GET /checklist_categories/1
  # GET /checklist_categories/1.json
  def show
  end

  # POST /checklist_categories
  # POST /checklist_categories.json
  def create
    @checklist_category = ChecklistCategory.new(checklist_category_params)

    respond_to do |format|
      if @checklist_category.save
        format.json { render action: 'show', status: :created, location: @checklist_category }
      else
        format.json { render json: @checklist_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklist_categories/1
  # PATCH/PUT /checklist_categories/1.json
  def update
    respond_to do |format|
      if @checklist_category.update(checklist_category_params)
        format.json { head :no_content }
      else
        format.json { render json: @checklist_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklist_categories/1
  # DELETE /checklist_categories/1.json
  def destroy
    @checklist_category.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist_category
      @checklist_category = ChecklistCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_category_params
      params.require(:checklist_category).permit(:id, :name)
    end
end
