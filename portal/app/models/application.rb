class Application < ActiveRecord::Base
	has_many :application_login_details, dependent: :destroy
	# accepts_nested_attributes_for :application_login_details, :allow_destroy => true
end
