class RemoveUseridFromChecklistEntries < ActiveRecord::Migration
  def change
    remove_column(:checklist_entries, :user_id, :integer)
  end
end
