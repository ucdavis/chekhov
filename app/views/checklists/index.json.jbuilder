json.array!(@checklists) do |checklist|
  if not @is_search
    json.extract! checklist, :user, :id, :name, :template_name, :public, :started, :finished, :ticket_number, :entry_count, :finished_count, :checklist_category, :archived
  else
    json.extract! checklist, :id, :name
  end
end
