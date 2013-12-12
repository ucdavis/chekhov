json.extract! @template, :id, :owner_id, :name
json.entries @template.entries do |entry|
  json.extract! entry, :content, :position
end
