json.array!(@applications) do |application|
  json.extract! application, :id, :name, :description, :url, :creator, :organization_id
  json.url application_url(application, format: :json)
end
