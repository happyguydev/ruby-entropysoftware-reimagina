json.array!(@color_ranges) do |color_range|
  json.extract! color_range, :id, :nombre, :min, :max, :color, :evaluation_type_id, :simce_range
  json.url color_range_url(color_range, format: :json)
end
