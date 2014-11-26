class AddApplicationIdToUsersRoles < ActiveRecord::Migration
  def change
    add_column :users_roles, :application_id, :integer
  end
end
