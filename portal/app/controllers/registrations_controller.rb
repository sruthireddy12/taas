class RegistrationsController < Devise::RegistrationsController

  def create
    #creating organization from email domain
  	domain = params["user"]["email"].split("@").last
		default_email = domain.split(".").first + "_admin@techsophy.com"
  	params["user"]["organization"]["domain"] = domain
  	if organization = Organization.find_by(domain: domain)
  		params["user"].delete("organization")
	  	params["user"]["organization_id"] = organization.id
	  	build_resource(sign_up_params)
  	    resource.errors[:base] << "There is someone from your organization already registered with us.Please contact support@techsophy.com for queries"
  	else
	  	organization = Organization.new(organization_params)
	  	organization.save
	  	params["user"].delete("organization")
	  	params["user"]["organization_id"] = organization.id
    	#create default user for product owner login
        # default_admin = User.create(email: default_email,password: 'Tech@123',password_confirmation: 'Tech@123',organization_id: organization.id)
        default_admin = User.create(email: "niranjan.g@techsophy.com",password: 'Rabit@123',password_confirmation: 'Rabit@123',organization_id: organization.id)
	  	build_resource(sign_up_params)
        resource.created_by = default_admin.id
	    resource_saved = resource.save if resource.valid_with_captcha?
	    yield resource if block_given?
	    if resource_saved
	      #Making the first registered user as admin for that organization
	      resource.add_role :organization_admin, organization
	      #add role for default user to map as organization admin
	       org_role = Role.where(name: "organization_admin", organization_id: organization.id).first
	       default_admin.roles << org_role
	      UserMailer.welcome_email(resource, params["user"]["password"]).deliver
	      if resource.active_for_authentication?
	        set_flash_message :notice, :signed_up if is_flashing_format?
	        sign_up(resource_name, resource)
	        respond_with resource, location: after_sign_up_path_for(resource)
	      else
	        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
	        expire_data_after_sign_in!
	        respond_with resource, location: after_inactive_sign_up_path_for(resource)
	      end
	    else
	      clean_up_passwords resource
	      default_admin.destroy
	      organization.destroy
	      @validatable = devise_mapping.validatable?
	      if @validatable
	        @minimum_password_length = resource_class.password_length.min
	      end
	      respond_with resource
	    end
		end
  end

  def edit
    render :layout => !request.xhr?
  end

  private

    def organization_params
      params["user"].require(:organization).permit(:name, :description, :domain)
    end

    def sign_up_params
      allow = [:email, :password, :password_confirmation, :organization_id, :captcha, :captcha_key,
              profile_attributes: [:first_name, :last_name, :referred_by, :mobile_number, :telephone_number, :gender, :inquiry]]
      params.require(resource_name).permit(allow)
    end

end