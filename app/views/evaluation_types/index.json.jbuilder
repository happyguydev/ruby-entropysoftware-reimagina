json.array!(@evaluation_types) do |evaluation_type|
  json.extract! evaluation_type, :id, :nombre, :descripcion
  json.url evaluation_type_url(evaluation_type, format: :json)
end
