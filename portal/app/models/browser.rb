class Browser < ActiveRecord::Base
	has_many :application_browsers
	has_many :applications,:through => :application_browsers, dependent: :destroy
	has_many :test_types,through: :application_browsers
end
