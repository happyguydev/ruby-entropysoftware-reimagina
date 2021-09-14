json.array!(@proc_types) do |proc_type|
  json.extract! proc_type, :id, :nombre, :descripcion
  json.url proc_type_url(proc_type, format: :json)
end
