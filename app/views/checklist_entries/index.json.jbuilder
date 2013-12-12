json.array!(@checklist_entries) do |checklist_entry|
  json.extract! checklist_entry, :id, :checklist_id, :template_entry_id, :user_id
  json.url checklist_entry_url(checklist_entry, format: :json)
end
