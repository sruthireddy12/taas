class Attachment < ActiveRecord::Base
  belongs_to :credential, polymorphic: true
  mount_uploader :file_path, AvatarUploader
end
