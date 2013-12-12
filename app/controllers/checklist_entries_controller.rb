class ChecklistEntriesController < ApplicationController
  before_action :set_checklist_entry, only: [:show, :edit, :update, :destroy]

  # GET /checklist_entries
  # GET /checklist_entries.json
  def index
    @checklist_entries = ChecklistEntry.all
  end

  # GET /checklist_entries/1
  # GET /checklist_entries/1.json
  def show
  end

  # GET /checklist_entries/new
  def new
    @checklist_entry = ChecklistEntry.new
  end

  # GET /checklist_entries/1/edit
  def edit
  end

  # POST /checklist_entries
  # POST /checklist_entries.json
  def create
    @checklist_entry = ChecklistEntry.new(checklist_entry_params)

    respond_to do |format|
      if @checklist_entry.save
        format.html { redirect_to @checklist_entry, notice: 'Checklist entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @checklist_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @checklist_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklist_entries/1
  # PATCH/PUT /checklist_entries/1.json
  def update
    respond_to do |format|
      if @checklist_entry.update(checklist_entry_params)
        format.html { redirect_to @checklist_entry, notice: 'Checklist entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @checklist_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklist_entries/1
  # DELETE /checklist_entries/1.json
  def destroy
    @checklist_entry.destroy
    respond_to do |format|
      format.html { redirect_to checklist_entries_url }
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
