class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @user = User.new
    @organizations = current_user.is_super_admin? ? Organization.all : [current_user.organization]
    @user.build_profile if @user.profile.blank?
    if current_user.is_super_admin?
      @users = User.all
    # elsif current_user.is_organization_admin?
    #   @users = current_user.organization.users
    else
      @users = User.where("created_by = #{current_user.id} or id = #{current_user.id}")
    end
  end

  def show
  end

  def new
  end


  def edit
    render :layout => !request.xhr?
  end

  def create
    @user = User.new(user_params)
    @user.organization_id = current_user.organization_id if @user.organization_id.blank?
    generated_password = Devise.friendly_token.first(8)+"#"+"2"
    @user.password =  generated_password
    @user.created_by = current_user.id
    respond_to do |format|
      if @user.save
        create_or_delete_role_mapping(params[:user][:is_organization_admin])
        UserMailer.welcome_email(@user, generated_password).deliver
        #flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { redirect_to admin_users_path, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
        format.js
      else
        #flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { render :action => "new"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
    end
    old_org = @user.organization_id
    respond_to do |format|
      if @user.update(user_params)
        delete_roles unless old_org == @user.organization_id
        create_or_delete_role_mapping(params[:user][:is_organization_admin])
        UserMailer.update(@user, params[:user][:password]).deliver
        format.html { redirect_to admin_users_path, :notice => 'User was successfully updated.' }
        format.json { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :ok }
    end
  end

  def create_or_delete_role_mapping(organization_admin)
    admin_role = Role.where(name: 'organization_admin', organization_id: @user.organization.id).first_or_create
    if organization_admin.to_i == 0
      @user.roles.delete(admin_role)
    else
      @user.roles << admin_role
    end
  end
  #delete user related roles, when user changes to other organizations
  def delete_roles
   @user.roles.destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :organization_id,:is_organization_admin, profile_attributes: [:first_name, :last_name,:mobile_number] )
    end
end
