class ApplicationController < ActionController::Base
  respond_to :html, :js, :json
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected
    def after_sign_in_path_for(resource_or_scope)
      applications_path
    end

    def layout_by_resource
      if devise_controller?
        "devise"
      else
        "application"
      end
  end
end
