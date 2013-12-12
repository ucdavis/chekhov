json.array!(@template_entries) do |template_entry|
  json.extract! template_entry, :id, :template_id, :content, :position
  json.url template_entry_url(template_entry, format: :json)
end
