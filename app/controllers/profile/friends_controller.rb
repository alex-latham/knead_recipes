class Profile::FriendsController < ApplicationController
  before_action :require_user

  def index
    @friends = current_user.friends
  end

  def create
    if current_user.add_friend(params[:username])
      current_user.reload
      flash['alert alert-success'] = 'Friend Added Successfully'
    else
      flash['alert alert-danger'] = 'Invalid entry, please try a different username'
    end
    redirect_to profile_friends_path
  end
end
