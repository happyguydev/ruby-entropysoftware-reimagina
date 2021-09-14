json.array!(@orders) do |order|
  json.extract! order, :id, :school_id, :year, :paymethod, :contract
  json.url order_url(order, format: :json)
end
