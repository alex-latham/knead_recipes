class SessionsController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    user = User.from_omniauth(response)
    if user.save
      session[:user_id] = user.id
      flash["alert alert-success"] = "Logged in as #{user.name}"
    else
      flash["alert alert-danger"] = user.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash["alert alert-success"] = 'You have been successfully logged out.'
    redirect_to root_path
  end
end
