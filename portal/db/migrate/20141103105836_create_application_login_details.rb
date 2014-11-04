class CreateApplicationLoginDetails < ActiveRecord::Migration
	def change
		create_table :application_login_details do |t|
			t.integer :application_id
			t.string :username
			t.string :password

			t.timestamps
		end
	end
end
