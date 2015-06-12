json.array!(@people) do |person|
  json.extract! person, :id, :nationalid, :birth_date, :first_name, :middle_name, :last_name, :addressA, :addressB, :addressC, :addressD, :phone_number, :mobile_number1, :mobile_number2, :role_id
  json.url person_url(person, format: :json)
end
