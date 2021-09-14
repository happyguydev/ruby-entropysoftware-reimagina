json.array!(@feed_items) do |feed_item|
  json.extract! feed_item, :id, :nombre
  json.url feed_item_url(feed_item, format: :json)
end
