class RolesUsersController < ApplicationController
	before_action :set_data, only: [:index, :create, :destroy]

	def index
		render :layout => !request.xhr?
	end

	def create
		unless params[:users].blank? && params[:roles].blank?
			params[:users].each do |u|
				user = User.find_by_id(u.to_i)
				params[:roles].each do |r|
					role = Role.find_by_id(r.to_i)
					users_roles = UsersRole.where(
						application_id: @application.id ,
						user_id: user.id ,
						role_id: role.id).first_or_create
				end
			end
		end
	end

	def destroy
		user = User.find_by_id(params[:user].to_i)
		role = Role.find_by_id(params[:role].to_i)
		users_roles = UsersRole.where(
			application_id: @application.id ,
			user_id: user.id ,
			role_id: role.id)
		users_roles.delete_all unless users_roles.blank?
	end

	private
		def set_data
			@application = Application.find_by_id(params[:id])
			@users = @application.organization.users
			@roles = @application.organization.roles
		end

end
