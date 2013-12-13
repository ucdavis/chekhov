class AddCheckedPropertyToChecklistEntry < ActiveRecord::Migration
  def change
    add_column :checklist_entries, :checked, :boolean
  end
end
