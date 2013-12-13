json.extract! @checklist, :id, :name, :template_id, :public
json.template_entries @checklist.template.entries do |entry|
  json.extract! entry, :content, :position
end
json.checklist_entries @checklist.entries do |entry|
  json.extract! entry, :template_entry_id, :user_id
end
