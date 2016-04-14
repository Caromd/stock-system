json.array!(@lines) do |line|
  json.extract! line, :id, :qtynew, :qtyused, :comment, :document_id, :item_id
  json.url line_url(line, format: :json)
end
