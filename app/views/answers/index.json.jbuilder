json.array!(@answers) do |answer|
  json.extract! answer, :id, :evaluation_id, :question_id, :student_id, :letra
  json.url answer_url(answer, format: :json)
end
