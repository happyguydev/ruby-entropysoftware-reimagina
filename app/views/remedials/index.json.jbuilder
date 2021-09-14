json.array!(@remedials) do |remedial|
  json.extract! remedial, :id, :nombre, :content_id, :level_id
  json.url remedial_url(remedial, format: :json)
end
