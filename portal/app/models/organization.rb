class Organization < ActiveRecord::Base
	has_many :users
	has_many :applications
	accepts_nested_attributes_for :users

	validates :domain, :presence => true, :uniqueness => true

end
