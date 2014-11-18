class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    if current_user.is_admin?
      @users = User.all
    elsif current_user.is_admin_of? current_user.organization
      @users = current_user.organization.users
    end
  end

  def show
  end


  def edit
  end

  def create
    @user = User.new(user_params)
    @user.organization_id = current_user.organization_id
    generated_password = Devise.friendly_token.first(8)+"#"+"2"
    @user.password =  generated_password
    respond_to do |format|
      if @user.save
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
 
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:first_name, :last_name] )
    end
end
