json.array!(@feed_scores) do |feed_score|
  json.extract! feed_score, :id, :nombre, :score
  json.url feed_score_url(feed_score, format: :json)
end
