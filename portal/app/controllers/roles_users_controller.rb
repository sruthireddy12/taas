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
					role.users << user unless role.users.include?(user)
				end
			end
		end
	end

	def destroy
	end

	private
		def set_data
			@application = Application.find_by_id(params[:id])
			@users = @application.organization.users
			@roles = @application.roles
		end

end
