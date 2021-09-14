json.array!(@bloom_abilities) do |bloom_ability|
  json.extract! bloom_ability, :id, :nombre, :descripcion
  json.url bloom_ability_url(bloom_ability, format: :json)
end
