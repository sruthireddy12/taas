class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @application = Application.new
    @organizations = current_user.is_super_admin? ? Organization.all : [current_user.organization]
    @application.credentials.build if @application.credentials.empty?
    if current_user.is_super_admin?
      @applications = Application.all
    elsif current_user.is_organization_admin?
      @applications = current_user.organization.applications
    else
      @applications = current_user.organization.applications
      # @applications = Application.with_roles([:admin, :user], current_user)
    end
    respond_with(@applications)
  end

  def show
    # respond_with(@application)
    render :layout => !request.xhr?
  end

  def new
    @application = Application.new
    render :layout => !request.xhr?
  end

  def edit
    render :layout => !request.xhr?
  end

  def create
    @application = Application.new(application_params)
    @application.creator = current_user
    @application.organization = current_user.organization
    @application.save
    ## Add file attacments for a application
    params[:application_file_paths].each do |file|
      @application.attachments.create(file_path: file)
    end if params[:application_file_paths] && !params[:application_file_paths].empty?
    respond_with(@application)
  end

  def update
    @application.update(application_params)
     params[:application_file_paths].each do |file|
      @application.attachments.create(file_path: file)
    end if params[:application_file_paths] && !params[:application_file_paths].empty?
    respond_with(@application)
  end

  def destroy
    @application.destroy
    respond_with(@application)
  end

  def delete_attachment
   attachment = Attachment.find_by_id(params[:attachment_id])
   @application = Application.find_by_id(params[:application_id])
   attachment.destroy unless attachment.blank?
  end

  private
    def set_application
      @application = Application.find(params[:id])
    end

    def application_params
      params.require(:application).permit(:name, :description, :url, :creator, :point_of_contact,:email,:prefered_contact_time,credentials_attributes: [:id,:role,:username,:password,file_paths: []])
    end
end
