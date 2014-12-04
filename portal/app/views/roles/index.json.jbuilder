json.array!(@roles) do |role|
  json.extract! role, :id, :name, :description, :resource_type, :resource_id
  json.url role_sample_url(role, format: :json)
end
