class SessionsController < ApplicationController
  def create
    session[:guest] = false if session[:guest] == true
    response = request.env['omniauth.auth']
    user = User.from_omniauth(response)
    session[:user_id] = user.id
    flash['alert alert-success'] = "Logged in as #{user.name}"
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash['alert alert-success'] = 'You have been successfully logged out.'
    redirect_to root_path
  end
end
