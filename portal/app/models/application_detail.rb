class ApplicationDetail < ActiveRecord::Base
	belongs_to :application
	validates_presence_of  :parameter, :value
  def self.get_app_details(app,label)
	 	ApplicationDetail.where(application_id: app.id,parameter: label.downcase)
  end


end

