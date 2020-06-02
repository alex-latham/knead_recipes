class FavoritesController < ApplicationController
  before_action :require_user

  def index
    @user = User.find_by(username: params[:username])
    recipe_ids = Favorite.get_recipe_ids(@user)
    @recipes = Recipe.search_by_ids(recipe_ids)
  end

  def create
    Favorite.create(user: current_user, recipe_id: params[:recipe_id])
    flash['alert alert-success'] = 'This recipe has been added to your favorites'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    favorite = Favorite.find_by(recipe_id: params[:id])
    favorite.destroy
    flash['alert alert-success'] = 'This recipe has been removed from your favorites'
    redirect_to profile_favorites_path
  end
end
