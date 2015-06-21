json.array!(@services) do |service|
  json.extract! service, :id, :name, :sub_name
  json.url service_url(service, format: :json)
end
