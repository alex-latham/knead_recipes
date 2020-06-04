class RecipeMailersController < ApplicationController
  before_action :require_user

  def create
    current_user.share_recipe_with_friends(recipe_mailer_params)
    flash['alert alert-success'] = 'This recipe has been sent to ALL of your friends'
    redirect_back(fallback_location: root_path)
  end

  private

  def recipe_mailer_params
    params.permit(:title, :id)
  end
end
