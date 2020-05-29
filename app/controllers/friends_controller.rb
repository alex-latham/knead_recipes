class FriendsController < ApplicationController

  def index
    @friends = current_user.load_friends
  end

  def create

    if current_user.add_friend(params[:email_address])
      current_user.reload
      flash[:success] = "Friend Added Successfully"
      redirect_to "/profile/friends"
    else
      flash[:error] = "Invalid Email Entered, Try Again"
      redirect_to "/profile/friends"
    end
  end
end
