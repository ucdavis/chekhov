class AddFinishedToChecklistEntries < ActiveRecord::Migration
  def change
    add_column :checklist_entries, :finished, :datetime
  end
end
