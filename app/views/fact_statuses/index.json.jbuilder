json.array!(@fact_statuses) do |fact_status|
  json.extract! fact_status, :id, :order_id, :fact_status_type_id, :comentario
  json.url fact_status_url(fact_status, format: :json)
end
