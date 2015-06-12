json.array!(@check_ins) do |check_in|
  json.extract! check_in, :id, :item_id, :person_id, :on_deadline
  json.url check_in_url(check_in, format: :json)
end
