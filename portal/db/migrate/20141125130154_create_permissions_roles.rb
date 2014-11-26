class CreatePermissionsRoles < ActiveRecord::Migration
  def change
    create_table :permissions_roles do |t|
    	t.references :permission
    	t.references :role
    end
    add_index(:permissions_roles, [ :permission_id, :role_id ])
  end
end
