class Organization < ActiveRecord::Base
	has_many :users
	accepts_nested_attributes_for :users

	validates :domain, :presence => true, :uniqueness => true

end
