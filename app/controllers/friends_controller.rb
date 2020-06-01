class FriendsController < ApplicationController
  before_action :require_user

  def index
    @user = User.find(params[:user_id])
  end
end
