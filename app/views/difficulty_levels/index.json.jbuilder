json.array!(@difficulty_levels) do |difficulty_level|
  json.extract! difficulty_level, :id, :name
  json.url difficulty_level_url(difficulty_level, format: :json)
end
