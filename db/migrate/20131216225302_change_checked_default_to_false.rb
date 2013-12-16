class ChangeCheckedDefaultToFalse < ActiveRecord::Migration
  def change
    change_column :checklist_entries, :checked, :boolean, :default => false
  end
end
