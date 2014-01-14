json.extract! @checklist, :id, :name, :template_name, :public, :user_id, :ticket_number, :comments, :finished
json.entries @checklist.entries do |entry|
  json.extract! entry, :id, :content, :position, :checked
  json.user_name entry.user.name if entry.user
end
