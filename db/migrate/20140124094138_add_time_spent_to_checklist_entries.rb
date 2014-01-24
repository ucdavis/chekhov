class AddTimeSpentToChecklistEntries < ActiveRecord::Migration
  def change
    add_column :checklist_entries, :time_spent, :integer
  end
end
