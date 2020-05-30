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
    current_user.update(bio_params)
    current_user.restrictions.delete_all
    diet_params.each do |restriction|
      current_user.restrictions.create(name: restriction.gsub('_', ' '))
    end
    flash["alert alert-success"] = 'Profile Successfully Updated'
    redirect_to profile_path
  end

  private

  def require_user
    render file: '/public/404' unless current_user
  end

  def diet_params
    params.permit(:vegetarian, :gluten_free, :vegan, :dairy_free, :keto)
  end

  def bio_params
    params.permit(:bio)
  end
end
