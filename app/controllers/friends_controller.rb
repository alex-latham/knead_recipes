class FriendsController < ApplicationController
  before_action :require_user

  def index
    @user = User.find(params[:id]).includes(:friends)
  end
end
