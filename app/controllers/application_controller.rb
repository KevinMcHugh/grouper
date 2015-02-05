class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :redirect_for_admin

  def redirect_for_admin
    return if cookies[:is_admin]
    if params[:controller] != 'logins' && !['add_person', 'remove_person'].include?(params[:action])
      redirect_to new_login_url
    end
  end
end
