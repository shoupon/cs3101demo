json.array!(@locations) do |location|
  json.extract! location, :id, :coordinate
  json.url location_url(location, format: :json)
end
