class ApplicationBrowser < ActiveRecord::Base
	belongs_to :application
	belongs_to :browser
	belongs_to :test_type

	def self.get_app_browser_details(application,browser)
		ApplicationBrowser.where(application_id: application.id,browser_id: browser.id)
	end
end
