json.array!(@checklists) do |checklist|
  json.extract! checklist, :id, :name, :template_name, :public, :user_id, :started, :finished
end
