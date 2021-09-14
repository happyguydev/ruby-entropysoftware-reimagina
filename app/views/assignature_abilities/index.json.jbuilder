json.array!(@assignature_abilities) do |assignature_ability|
  json.extract! assignature_ability, :id, :nombre, :descripcion
  json.url assignature_ability_url(assignature_ability, format: :json)
end
