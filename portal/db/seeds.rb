# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin_organization = Organization.create(name: 'TechSophy', description: '', domain: 'techsophy.com')
super_admin_user = User.create(email: "admin@techsophy.com", password: "tech@123", organization_id: admin_organization.id)
super_admin_role = super_admin_user.add_role :super_admin
# super_admin_role = super_admin_user.add_role :super_admin , admin_organization.id



organization_techrain = Organization.create(name: 'Techrains',domain: 'techrains.com')
techrain_user = User.create(email: "admin@techrains.com", password: "tech@123", organization_id: organization_techrain.id)
techrain_admin = techrain_user.add_role :admin , organization_techrain.id
app = Application.create(name: 'PDF Ginie', description: '', url: '172.16.0.121:3000', creator: techrain_user.id, organization_id: organization_techrain.id, point_of_contact: 'techrains', email: 'abc@techrains.com', prefered_contact_time: Time.now)
