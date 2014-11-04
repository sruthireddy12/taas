class CreateApplications < ActiveRecord::Migration
	def change
		create_table :applications do |t|
			t.string :name
			t.text :description
			t.integer :creator
			t.string :url, limit: 2047

			t.timestamps
		end
	end
end
