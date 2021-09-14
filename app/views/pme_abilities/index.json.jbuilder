json.array!(@pme_abilities) do |pme_ability|
  json.extract! pme_ability, :id, :nombre, :descripcion
  json.url pme_ability_url(pme_ability, format: :json)
end
