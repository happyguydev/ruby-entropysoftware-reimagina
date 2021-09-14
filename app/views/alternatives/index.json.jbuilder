json.array!(@alternatives) do |alternative|
  json.extract! alternative, :id, :texto, :correcta, :question_id
  json.url alternative_url(alternative, format: :json)
end
