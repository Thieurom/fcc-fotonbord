class SessionsController < ApplicationController

  def create
    begin
      user = User.from_auth(request.env['omniauth.auth'])
      log_in user
    rescue
    end
    redirect_to root_path
  end

  def auth_failure
    redirect_to root_url
  end
end
