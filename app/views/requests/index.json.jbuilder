json.array!(@requests) do |request|
  json.extract! request, :id, :person_id, :item_id, :description
  json.url request_url(request, format: :json)
end
