class User < ActiveRecord::Base
	belongs_to :organization
	rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  apply_simple_captcha :add_to_base => true

  validates_format_of :email, without: /(\W|^)[\w.+\-]{0,25}@(yahoo|hotmail|gmail)\.com(\W|$)/, :message => 'Please enter a valid office address', allow_blank: true, if: :email_changed?
  validates :organization_id, :presence => true
end
