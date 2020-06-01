class FriendsController < ApplicationController
  before_action :require_user

  def index
    @user = User.find_by(username: params[:username])
  end
end
