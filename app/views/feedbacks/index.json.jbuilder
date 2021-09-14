json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :order_id, :comentario
  json.url feedback_url(feedback, format: :json)
end
