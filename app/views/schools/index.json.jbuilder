json.array!(@schools) do |school|
  json.extract! school, :id, :nombre, :rut, :direccion, :email, :telefono, :info_contacto
  json.url school_url(school, format: :json)
end
