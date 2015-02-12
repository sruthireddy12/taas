class TestType < ActiveRecord::Base
	 has_and_belongs_to_many :applications,join_table: :applications_test_types
	 has_many :browsers,through: :application_browsers
	 has_many :application_browsers
end
