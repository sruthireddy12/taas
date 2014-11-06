class ApplicationLoginDetail < ActiveRecord::Base
	belongs_to :application
	has_many :file_uploads, through: :application_login_detail, dependent: :destroy
	accepts_nested_attributes_for :file_uploads, :allow_destroy => true
end
