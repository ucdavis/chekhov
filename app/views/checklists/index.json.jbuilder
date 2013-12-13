json.array!(@checklists) do |checklist|
  json.extract! checklist, :id, :name, :template_id, :public, :user_id, :started, :finished
end
