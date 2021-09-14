json.array!(@ability_contents) do |ability_content|
  json.extract! ability_content, :id, :pme_ability_id, :nombre, :descripcion
  json.url ability_content_url(ability_content, format: :json)
end
