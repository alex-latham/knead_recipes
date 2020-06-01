class UsersController < ApplicationController
  before_action :require_user

  def show
    @user = User.find_by(username: params[:username])
  end
end
