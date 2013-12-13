json.array!(@templates) do |template|
  json.extract! template, :id, :owner_id, :name
  json.url template_url(template, format: :json)
  json.entries template.entries do |entry|
    json.extract! entry, :content, :position
  end
end
