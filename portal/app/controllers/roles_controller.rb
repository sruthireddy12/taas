class RolesController < ApplicationController
	before_action :set_role, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /roles
  # GET /roles.json
  def index
    if current_user.is_super_admin?
      @roles = Role.all
    else
      @roles = current_user.organization.roles
    end
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
    set_action_permission
    render :layout => !request.xhr?
  end

  # GET /roles/1/edit
  def edit
    set_action_permission
    render :layout => !request.xhr?
  end

  # POST /roles
  # POST /roles.json
  def create
    @role =  Role.new(role_params)
    @role.organization_id = current_user.organization.id
    if @role.save
      role_permission_mappings(params[:permission])
    end
    set_action_permission
    respond_with(@role)
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    set_action_permission
    if @role.update(role_params)
      role_permission_mappings(params[:permission])
    end
    respond_with(@role)
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role sample was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def role_permission_mappings(permission_ids=[])
    @role.permissions.delete_all
    permission_ids.each do |p_id|
      permission = Permission.find_by_id(p_id.to_i)
      @role.permissions << permission unless @role.permissions.include?(permission)
    end
  end

  def destory_all
    params[:role_id].each do |role_id|
      @role =  Role.find_by_id(role_id).destroy
    end
    render js: "window.location = '#{roles_url}'"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    def set_action_permission
      @all_actions = StaticData::ACTIONS
      @permissions = Permission.all.group('subject_class')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :description,:organization_id)
    end
end
