json.array!(@applications) do |application|
  json.extract! application, :id, :name, :description, :user_id, :url
  json.url application_url(application, format: :json)
end
