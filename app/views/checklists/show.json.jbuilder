json.extract! @checklist, :id, :name, :template_name, :public, :user_id, :ticket_number, :finished
json.entries @checklist.entries do |entry|
  json.extract! entry, :id, :content, :position, :checked, :finished, :updated_at, :completed_by 
  json.user_name entry.completed_by if entry.completed_by
end
json.comments_attributes @checklist.comments do |comment|
  json.extract! comment, :id, :content, :author, :created_at
end
