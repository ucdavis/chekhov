json.array!(@checklists) do |checklist|
  json.extract! checklist, :user, :id, :name, :template_name, :public, :user_id, :started, :finished, :ticket_number
end
