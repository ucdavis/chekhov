json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :author, :checklist_id
  json.url comment_url(comment, format: :json)
end
