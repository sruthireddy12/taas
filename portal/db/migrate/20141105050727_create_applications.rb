class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.text :description
      t.string :url
      t.integer :creator
      t.references :organization, index: true

      t.timestamps
    end
  end
end
