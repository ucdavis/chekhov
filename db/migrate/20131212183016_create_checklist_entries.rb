class CreateChecklistEntries < ActiveRecord::Migration
  def change
    create_table :checklist_entries do |t|
      t.integer :checklist_id
      t.integer :template_entry_id
      t.integer :user_id

      t.timestamps
    end
  end
end
