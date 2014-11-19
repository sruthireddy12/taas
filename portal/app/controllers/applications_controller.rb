class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @application = Application.new
    @application.credentials.build if @application.credentials.empty?
    if current_user.is_admin?
      @applications = Application.all
    elsif current_user.is_admin_of? current_user.organization
      @applications = current_user.organization.applications
    else
      @applications = Application.with_roles([:admin, :user], current_user)
    end
    respond_with(@applications)
  end

  def show
    respond_with(@application)
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
    respond_with(@application)
  end

  def destroy
    @application.destroy
    respond_with(@application)
  end

  private
    def set_application
      @application = Application.find(params[:id])
    end

    def application_params
      params.require(:application).permit(:name, :description, :url, :creator, :point_of_contact,:email,:prefered_contact_time,credentials_attributes: [:id,:role,:username,:password,file_paths: []])
    end
end
