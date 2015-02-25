class Application < ActiveRecord::Base
  belongs_to :organization
  has_many :credentials, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator'
  belongs_to :application_types
  has_and_belongs_to_many :test_types, join_table: :applications_test_types
  has_many :browsers ,through: :application_browsers
  has_many :application_browsers
  has_many :application_details

  validates_presence_of  :name, :organization_id,:email,:application_type_id

  validates_format_of :name, :with => /[\w \.\-@]+/,:message => "can only contain letters and numbers."
  validates_length_of :name, :within => 3..50, :too_long => "name is too long", :too_short => "name is too short"
  validates_uniqueness_of :name, scope: :organization_id

  accepts_nested_attributes_for :credentials, reject_if: proc { |attributes| attributes['role'].blank? }
  accepts_nested_attributes_for :application_details, reject_if: proc { |attributes| attributes['value'].blank? }
  # accepts_nested_attributes_for :application_browsers
  accepts_nested_attributes_for :application_browsers, reject_if: proc { |attributes| attributes['version'].blank? }
  accepts_nested_attributes_for :test_types, reject_if: proc { |attributes| attributes['name'].blank? }

  # get all organization roles without organization admin and super admin
  def get_valid_roles
    self.organization.roles.map{ |role| 
      role if (role.name != 'organization_admin' && role.name != 'super_admin') 
      }.compact
  end

  def get_valid_users
    self.organization.users.map{ |user| 
      user if (!user.has_role?('organization_admin',self.organization) && !user.has_role?('super_admin',self.organization))
      }.compact
  end

end
