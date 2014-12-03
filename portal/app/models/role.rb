class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :permissions
  belongs_to :organization

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :organization_id

  def super_admin_org_admin(current_user)
  	result = current_user.is_super_admin? && self.name == 'super_admin'
  	if result == false
  		result = current_user.is_organization_admin? && self.name == 'organization_admin'
  	end
  	result
  end
  
end
