json.extract! @template, :id, :owner_id, :name, :desc, :template_category, :force_private
json.entries @template.entries do |entry|
  json.extract! entry, :id, :content, :position
end
