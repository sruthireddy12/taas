class User < ActiveRecord::Base
  attr_accessor :is_organization_admin
	belongs_to :organization
  has_one :profile
  has_and_belongs_to_many :roles, join_table: :users_roles, dependent: :destroy
  accepts_nested_attributes_for :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  apply_simple_captcha :add_to_base => true
  delegate :first_name, :last_name, :referred_by, :mobile_number, :telephone_number, :gender, :user, to: :profile, allow_nil: true

  validates_format_of :email, without: /(\W|^)[\w.+\-]{0,25}@(yahoo|hotmail|gmail)\.com(\W|$)/, :message => 'Please enter a valid office address', allow_blank: true, if: :email_changed?
  validates :organization_id, :presence => true
  validates_format_of :password, with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[-+_!@#$%^&*.,?])).+\z/,
    :message => "must include at least one lowercase letter, one uppercase letter, and one digit and one special character",
    allow_blank: true

  def full_name
    first_name.to_s + last_name.to_s if (first_name || last_name)
  end

  def is_organization_admin?
    self.has_role?(:organization_admin, organization)
  end

  def is_super_admin?
    self.has_role?(:super_admin)
  end

  def find_roles(app_id)
    roles = []
    unless app_id.blank?
      roles_users = RolesUser.where(application_id: app_id,user_id: self.id)
      if roles_users.blank?
        roles = []
      else
        role_ids = roles_users.map{|ur| ur.role_id}
        roles = Role.where(id: role_ids)
      end
    end
  end

  def has_role?(role_name,organization=nil)
    if organization.blank?
      number_of_roles = self.roles.where(name: role_name).count
    else
      number_of_roles = self.roles.where(name: role_name, organization_id: organization.id).count
    end
    (number_of_roles == 0) ? false : true
  end

  def add_role(role_name,organization=nil)
    if role_name.to_s.downcase == 'super_admin'
      role = Role.create(name: role_name)
    else
      role = Role.create(name: role_name, organization_id: organization.id)
    end
    self.roles << role unless role.blank?
  end

  def is_organization_admin
    is_organization_admin?
  end

  # def is_organization_admin=(val)
    # admin_role = Role.where(name: 'organization_admin', organization_id: organization.id).first_or_create
    # if val.to_i == 0
    #   self.roles.delete(admin_role)
    # else
    #   self.roles << admin_role
    # end
  # end

end
