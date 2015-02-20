class AddApplicationTypeIdToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :application_type_id, :integer
    add_column :applications, :technology, :string
    add_column :applications, :database, :string
  end
end
