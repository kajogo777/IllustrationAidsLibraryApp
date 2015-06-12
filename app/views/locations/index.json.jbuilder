json.array!(@locations) do |location|
  json.extract! location, :id, :loc1, :loc2, :loc3, :description
  json.url location_url(location, format: :json)
end
