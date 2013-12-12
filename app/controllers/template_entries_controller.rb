class TemplateEntriesController < ApplicationController
  before_action :set_template_entry, only: [:show, :edit, :update, :destroy]

  # GET /template_entries
  # GET /template_entries.json
  def index
    @template_entries = TemplateEntry.all
  end

  # GET /template_entries/1
  # GET /template_entries/1.json
  def show
  end

  # GET /template_entries/new
  def new
    @template_entry = TemplateEntry.new
  end

  # GET /template_entries/1/edit
  def edit
  end

  # POST /template_entries
  # POST /template_entries.json
  def create
    @template_entry = TemplateEntry.new(template_entry_params)

    respond_to do |format|
      if @template_entry.save
        format.html { redirect_to @template_entry, notice: 'Template entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @template_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @template_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /template_entries/1
  # PATCH/PUT /template_entries/1.json
  def update
    respond_to do |format|
      if @template_entry.update(template_entry_params)
        format.html { redirect_to @template_entry, notice: 'Template entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @template_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_entries/1
  # DELETE /template_entries/1.json
  def destroy
    @template_entry.destroy
    respond_to do |format|
      format.html { redirect_to template_entries_url }
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
