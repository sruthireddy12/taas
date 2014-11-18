class Credential < ActiveRecord::Base
	attr_writer :file_paths
	belongs_to :application
	has_many :attachments, as: :attachable, dependent: :destroy

	def file_paths=(files)
		id = self.id
		files.each do |file|
		  id  ? self.attachments.create(file_path: file) : self.attachments.build(file_path: file)
		end
	end
end
