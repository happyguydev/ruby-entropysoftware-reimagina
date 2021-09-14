json.array!(@fact_status_types) do |fact_status_type|
  json.extract! fact_status_type, :id, :nombre
  json.url fact_status_type_url(fact_status_type, format: :json)
end
