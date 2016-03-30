json.array!(@templates) do |template|
  if @is_search
    json.extract! template, :id, :name, :checklist_count
  else
    json.extract! template, :id, :owner_id, :name, :checklist_count, :template_category, :force_private
    json.url template_url(template, format: :json)
    json.entries template.entries do |entry|
      json.extract! entry, :content, :position
    end
  end
end
