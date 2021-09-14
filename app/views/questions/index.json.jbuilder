json.array!(@questions) do |question|
  json.extract! question, :id, :texto, :assignature_id, :level_id, :bloom_ability_id, :axes_content_id, :ability_content_id, :unit_id, :learning_goal_id
  json.url question_url(question, format: :json)
end
