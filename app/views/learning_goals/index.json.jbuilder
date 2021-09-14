json.array!(@learning_goals) do |learning_goal|
  json.extract! learning_goal, :id, :numero, :descripcion, :assignature_id, :level_id
  json.url learning_goal_url(learning_goal, format: :json)
end
