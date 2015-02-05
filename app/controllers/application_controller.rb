class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :redirect_for_admin

  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_SECRET'], except: [:add_person, :remove_person]

end
