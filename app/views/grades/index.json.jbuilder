json.array!(@grades) do |grade|
  json.extract! grade, :id, :school_id, :grado, :letra, :year
  json.url school_grades_url(grade, format: :json)
end
