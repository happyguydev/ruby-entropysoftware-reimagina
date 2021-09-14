json.array!(@order_statuses) do |order_status|
  json.extract! order_status, :id, :order_id, :status_type_id, :comentario
  json.url order_status_url(order_status, format: :json)
end
