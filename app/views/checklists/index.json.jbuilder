json.array!(@checklists) do |checklist|
  json.extract! checklist, :id, :template_id, :public, :user_id, :started, :finished
  json.url checklist_url(checklist, format: :json)
end
