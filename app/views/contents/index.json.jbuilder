json.array!(@contents) do |content|
  json.extract! content, :id, :nombre, :descripcion, :assignature_id
  json.url content_url(content, format: :json)
end
