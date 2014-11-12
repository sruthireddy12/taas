class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :referred_by
      t.integer :mobile_number
      t.integer :telephone_number
      t.string  :gender
      t.references :user

      t.timestamps
    end
  end
end
