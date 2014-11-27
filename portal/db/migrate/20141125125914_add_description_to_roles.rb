class AddDescriptionToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :description, :text
    add_column :roles, :organization_id, :integer
  end
end
