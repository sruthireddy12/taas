class CreateApplicationDetails < ActiveRecord::Migration
  def change
    create_table :application_details do |t|
      t.string :parameter
      t.string :value
      t.integer :application_id
      t.timestamps
    end
  end
end
