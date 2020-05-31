class Profile::FriendsController < ApplicationController
  before_action :require_user

  def index
    @friends = current_user.load_friends
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    if current_user.add_friend(params[:email_address])
      current_user.reload
      flash['alert alert-success'] = 'Friend Added Successfully'
    else
      flash['alert alert-danger'] = 'Invalid Email Entered, Try Again'
    end
    redirect_to '/profile/friends'
  end
end
