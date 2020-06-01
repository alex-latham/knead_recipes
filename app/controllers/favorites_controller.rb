class FavoritesController < ApplicationController
  before_action :require_user

  def index
    @user = User.find(params[:user_id])
    recipe_ids = Favorite.where(user: @user).pluck(:recipe_id).join(',')
    @recipes = Recipe.search_by_ids(recipe_ids)
  end
end
