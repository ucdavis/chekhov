json.extract! @template, :id, :owner_id, :name, :desc, :template_category
json.entries @template.entries do |entry|
  json.extract! entry, :id, :content, :position
end
