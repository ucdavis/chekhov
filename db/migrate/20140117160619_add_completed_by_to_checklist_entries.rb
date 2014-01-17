class AddCompletedByToChecklistEntries < ActiveRecord::Migration
  def change

    # add author to checklist_entries
    add_column(:checklist_entries, :completed_by, :string)

    Authorization.ignore_access_control(true)

    # harvest name from users and save into new column    
    ChecklistEntry.reset_column_information

    ChecklistEntry.all.each do |c|
      if !c.user_id.blank? && !c.user.name.blank?
        c.completed_by = c.user.name
        c.save
      end
    end
  end
end
