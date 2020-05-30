class SessionsController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    user = User.from_omniauth(response)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.name}"
      redirect_to profile_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have been successfully logged out.'
    redirect_to root_path
  end
end
