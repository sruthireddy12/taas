json.array!(@organizations) do |admin_organization|
  json.extract! admin_organization, :id
  json.url admin_organization_url(admin_organization, format: :json)
end
