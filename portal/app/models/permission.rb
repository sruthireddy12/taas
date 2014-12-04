class Permission < ActiveRecord::Base
	has_and_belongs_to_many :roles,dependent: :destroy

	def get_all_permissions
		Permission.where(subject_class: self.subject_class)
	end

	def get_permission_with_action(action)
		Permission.where(action: action, subject_class: self.subject_class).first
	end
end
