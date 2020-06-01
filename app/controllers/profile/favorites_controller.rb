class Profile::FavoritesController < ApplicationController
  before_action :require_user

  def index
    recipe_ids = Favorite.where(user: current_user).pluck(:recipe_id).join(',')
    @recipes = Recipe.search_by_ids(recipe_ids)
  end

  def create
    Favorite.create(user: current_user, recipe_id: params[:id])
    flash['alert alert-success'] = 'This recipe has been added to your favorites'
    redirect_to recipe_path(params[:id])
  end

  def destroy
    favorite = Favorite.find_by(recipe_id: params[:id])
    favorite.destroy
    flash['alert alert-success'] = 'This recipe has been removed from your favorites'
    redirect_to profile_favorites_path
  end
end
