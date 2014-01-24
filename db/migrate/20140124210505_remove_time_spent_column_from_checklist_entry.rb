class RemoveTimeSpentColumnFromChecklistEntry < ActiveRecord::Migration
  def change
    remove_column :checklist_entries, :time_spent
  end
end
