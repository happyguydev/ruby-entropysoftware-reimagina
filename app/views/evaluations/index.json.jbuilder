json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :nombre, :year, :evaluation_type_id, :assignature_id, :level_id
  json.url evaluation_url(evaluation, format: :json)
end
