class AddChecklistCountToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :checklist_count, :int, :default => 0
  end
end
