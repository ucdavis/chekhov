json.extract! @checklist, :id, :name, :template_name, :public, :user_id
json.entries @checklist.entries do |entry|
  json.extract! entry, :id, :content, :position, :user_id, :checked
end
