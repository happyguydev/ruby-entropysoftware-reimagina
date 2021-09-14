json.array!(@students) do |student|
  json.extract! student, :id, :nombre, :apellido, :rut
  json.url grade_students_url(student, format: :json)
end
