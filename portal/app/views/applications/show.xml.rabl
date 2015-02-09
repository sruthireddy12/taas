object @application
attributes :id,:name

node(:edit_url) { |application| edit_application_url(application) }

child :attachments do
  attributes :id, :file_path,:attachable_id
end