class LoginsController < ApplicationController

  def new
    @disable_navbar = true
  end

  def create
    if params['login']['key'] == ENV['RAILS_SECRET_IS_DUMB']
      cookies[:is_admin] = true
    end
    redirect_to root_path
  end
end