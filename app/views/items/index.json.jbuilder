json.array!(@items) do |item|
  json.extract! item, :id, :code, :description
  json.url item_url(item, format: :json)
end
