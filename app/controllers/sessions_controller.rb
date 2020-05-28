class SessionsController < ApplicationController

  def create
    user = User.find_by(email_address: params[:email_address])
    session[:user_id] = user.id
    flash[:success] = "Logged in sucessfully"
    redirect_to "/"
  end

end
