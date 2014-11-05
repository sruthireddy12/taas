class ApplicationController < ActionController::Base
  respond_to :html, :js, :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    def after_sign_in_path_for(resource_or_scope)
      applications_path
    end
end
