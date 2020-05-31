class FavoritesController < ApplicationController
  def create
    Favorite.create(user: current_user, recipe_id: params[:recipe_id])
    flash[:success] = 'This recipe has been added to your favorites'
    redirect_to recipe_path(params[:recipe_id])
  end
end
