json.extract! @checklist, :id, :name, :template_name, :public, :user_id, :ticket_number, :finished
json.entries @checklist.entries do |entry|
  json.extract! entry, :id, :content, :position, :checked, :user_id, :finished
  json.user_name entry.user.name if entry.user
end
json.comments_attributes @checklist.comments do |comment|
  json.extract! comment, :id, :content, :author, :created_at
end
