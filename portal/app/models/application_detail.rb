class ApplicationDetail < ActiveRecord::Base
	belongs_to :application
	validates_presence_of  :parameter, :value
end

