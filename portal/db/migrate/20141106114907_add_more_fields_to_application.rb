class AddMoreFieldsToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :point_of_contact, :string
    add_column :applications, :email, :string
    add_column :applications, :prefered_contact_time, :time
  end
end
