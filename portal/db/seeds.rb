# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


organization = Organization.where(name: 'TechSophy', description: '', domain: 'techsophy.com').first_or_create
super_admin_user = User.create(email: "admin@techsophy.com", password: "Tech@123",organization_id: organization.id)
admin_role = super_admin_user.add_role :super_admin
admin_user = User.create(email: "admin@techrains.com", password: "Tech@123",organization_id: organization.id)
admin_role = admin_user.add_role :organization_admin, organization
Permission.where(subject_class: 'Application',action: 'view').first_or_create
Permission.where(subject_class: 'Application',action: 'edit').first_or_create
Permission.where(subject_class: 'Application',action: 'assign_role').first_or_create
Permission.where(subject_class: 'User',action: 'create').first_or_create
Permission.where(subject_class: 'User',action: 'delete').first_or_create
Permission.where(subject_class: 'Document',action: 'upload').first_or_create
Permission.where(subject_class: 'Document',action: 'download').first_or_create
Permission.where(subject_class: 'Build',action: 'trigger').first_or_create

['Cordys Bpm', 'Pega Bpm', 'Oracle Bpm'].each do |name|
  ApplicationType.create(name: name)
end

['Functional Testing', 'Web Service', 'Performance Testing','Security'].each do |name|
  TestType.create(name: name)
end


['firefox', 'chrome', 'ie','safari', 'opera'].each do |name|
  Browser.create(name: name)
end


# organization_techrain = Organization.create(name: 'Techrains',domain: 'techrains.com')
# techrain_user = User.create(email: "admin@techrains.com", password: "tech@123", organization_id: organization_techrain.id)
# techrain_admin = techrain_user.add_role :admin , organization_techrain.id
# app = Application.create(name: 'PDF Ginie', description: '', url: '172.16.0.121:3000', creator: techrain_user.id, organization_id: organization_techrain.id, point_of_contact: 'techrains', email: 'abc@techrains.com', prefered_contact_time: Time.now)
