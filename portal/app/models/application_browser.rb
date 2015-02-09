class ApplicationBrowser < ActiveRecord::Base
	belongs_to :application
	belongs_to :browser
end
