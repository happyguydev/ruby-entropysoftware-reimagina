json.array!(@proccesses) do |proccess|
  json.extract! proccess, :id, :order_id, :nombre, :proc_type_id, :monto
  json.url proccess_url(proccess, format: :json)
end
