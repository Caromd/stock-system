json.array!(@documents) do |document|
  json.extract! document, :id, :code, :docdate, :comment, :user_id
  json.url document_url(document, format: :json)
end
