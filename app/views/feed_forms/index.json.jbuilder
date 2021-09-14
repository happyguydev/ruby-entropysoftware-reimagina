json.array!(@feed_forms) do |feed_form|
  json.extract! feed_form, :id, :feedback_id, :feed_item_id, :feed_score_id
  json.url feed_form_url(feed_form, format: :json)
end
