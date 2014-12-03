class RemoveColumnInRoles < ActiveRecord::Migration
  def change
  	change_table :roles do |t|
    	t.remove_references :resource, :polymorphic => true
  	end
  end
end
