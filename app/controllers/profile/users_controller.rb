class Profile::UsersController < ApplicationController
  before_action :require_user

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    require "pry"; binding.pry
    redirect_to profile_path
  end

  private

  def require_user
    render file: "/public/404" unless current_user
  end

  def update_params
    params.permit(:vegetarian, :gluten_free, :vegan, :diary_free, :keto)
  end
end
