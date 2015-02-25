module ApplicationHelper
	def action_active(object,action='')
		result = organization_or_super_admin = current_user.is_super_admin? || current_user.is_organization_admin?
		roles = object.class.to_s == 'Application' ?  current_user.find_roles(object.id) : current_user.roles
		if organization_or_super_admin == false
			result = !roles.map{|r| r.permissions }.flatten.uniq
			.select { |p| p.subject_class == object.class.to_s && p.action == action}.blank?
		end
		result
	end
end
