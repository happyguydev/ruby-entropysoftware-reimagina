json.array!(@instruments) do |instrument|
  json.extract! instrument, :id, :nombre, :evaluation_id
  json.url instrument_url(instrument, format: :json)
end
