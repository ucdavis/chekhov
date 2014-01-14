json.extract! @checklist, :id, :name, :template_name, :public, :user_id, :ticket_number, :comments, :finished
json.entries @checklist.entries do |entry|
  json.extract! entry, :id, :content, :position, :checked, :user_id, :finished
  json.user_name entry.user.name if entry.user
end
