json.array!(@buy_orders) do |buy_order|
  json.extract! buy_order, :id, :order_id, :monto, :fecha, :numero, :num_licitacion, :comentario
  json.url buy_order_url(buy_order, format: :json)
end
