module ApplicationHelper
	def action_active(object,action='')
		result = organization_or_super_admin = current_user.is_super_admin? || current_user.is_organization_admin?
		if organization_or_super_admin == false
			result = !current_user.find_roles(object.id).map{|r| r.permissions }.flatten.uniq
			.select { |p| p.subject_class == object.class.to_s && p.action == action}.blank? if object.class.to_s == 'Application'
		end
		result
	end
end
