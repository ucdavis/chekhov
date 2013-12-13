class AdjustColumnsSoChecklistEntriesCanCopyNotAssociateWithTemplateEntryData < ActiveRecord::Migration
  def change
    remove_column :checklist_entries, :template_entry_id
    add_column :checklist_entries, :position, :integer
    add_column :checklist_entries, :content, :text
  end
end
