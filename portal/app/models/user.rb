class User < ActiveRecord::Base
	belongs_to :organization
	rolify
  has_one :profile
  accepts_nested_attributes_for :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  apply_simple_captcha :add_to_base => true

  validates_format_of :email, without: /(\W|^)[\w.+\-]{0,25}@(yahoo|hotmail|gmail)\.com(\W|$)/, :message => 'Please enter a valid office address', allow_blank: true, if: :email_changed?
  validates :organization_id, :presence => true
  validates_format_of :password, with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[-+_!@#$%^&*.,?])).+\z/,:message => "must include at least one lowercase letter, one uppercase letter, and one digit and one special character"
end
