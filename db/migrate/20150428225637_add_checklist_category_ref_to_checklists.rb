class AddChecklistCategoryRefToChecklists < ActiveRecord::Migration
  def change
    add_reference :checklists, :checklist_category, index: true, foreign_key: true
  end
end
