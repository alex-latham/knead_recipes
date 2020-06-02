class Profile::UsersController < ApplicationController
  before_action :require_user

  def show
    @user = current_user
  end

  def edit
    @user = current_user
    @restrictions = current_user.restrictions.map(&:name)
  end

  def update
    current_user.update(profile_params)
    current_user.restrictions.delete_all
    diet_params.each do |restriction|
      current_user.restrictions.create(name: restriction.gsub('_', ' '))
    end
    flash['alert alert-success'] = 'Profile Successfully Updated'
    redirect_to profile_path
  end

  private

  def diet_params
    params.permit(:vegetarian, :gluten_free, :vegan, :dairy_free, :ketogenic)
  end

  def profile_params
    params.permit(:bio, :username)
  end
end
