json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :order_id, :numero, :fecha, :monto
  json.url invoice_url(invoice, format: :json)
end
