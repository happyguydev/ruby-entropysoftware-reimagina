json.array!(@proc_type_fathers) do |proc_type_father|
  json.extract! proc_type_father, :id, :nombre, :short_name
  json.url proc_type_father_url(proc_type_father, format: :json)
end
