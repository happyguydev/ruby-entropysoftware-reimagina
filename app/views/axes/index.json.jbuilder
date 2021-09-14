json.array!(@axes) do |axis|
  json.extract! axis, :id, :nombre, :descripcion
  json.url axis_url(axis, format: :json)
end
