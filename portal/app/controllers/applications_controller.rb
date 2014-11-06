class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
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
    respond_with(@application)
  end

  def edit
  end

  def create
    @application = Application.new(application_params)
    @application.creator = current_user.id
    @application.save
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
      params.require(:application).permit(:name, :description, :url, :creator, :organization_id)
    end
end
