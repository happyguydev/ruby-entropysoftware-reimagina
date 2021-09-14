json.array!(@axes_contents) do |axes_content|
  json.extract! axes_content, :id, :axis_id, :nombre, :descripcion
  json.url axes_content_url(axes_content, format: :json)
end
