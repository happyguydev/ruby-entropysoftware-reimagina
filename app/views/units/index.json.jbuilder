json.array!(@units) do |unit|
  json.extract! unit, :id, :assignature_id, :level_id, :numero, :descripcion
  json.url unit_url(unit, format: :json)
end
