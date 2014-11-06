class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

end