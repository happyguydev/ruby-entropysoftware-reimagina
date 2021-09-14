json.array!(@proccess_instruments) do |proccess_instrument|
  json.extract! proccess_instrument, :id, :proccess_id, :instrument_id
  json.url proccess_instrument_url(proccess_instrument, format: :json)
end
