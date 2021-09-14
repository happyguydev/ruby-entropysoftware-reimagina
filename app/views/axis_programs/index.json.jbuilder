json.array!(@axis_programs) do |axis_program|
  json.extract! axis_program, :id, :nombre, :descripcion, :assignature_id
  json.url axis_program_url(axis_program, format: :json)
end
