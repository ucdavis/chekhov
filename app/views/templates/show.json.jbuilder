json.extract! @template, :id, :owner_id, :name, :desc
json.entries @template.entries do |entry|
  json.extract! entry, :id, :content, :position
end
