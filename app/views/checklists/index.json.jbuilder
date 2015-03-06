json.array!(@checklists) do |checklist|
  if not @is_search
    json.extract! checklist, :user, :id, :name, :template_name, :public, :user_id, :started, :finished, :ticket_number
  else
    json.extract! checklist, :id, :name
  end
end
