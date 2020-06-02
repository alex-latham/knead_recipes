class FavoritesController < ApplicationController
  before_action :require_user

  def index
    @user = User.find_by(username: params[:username])
    recipe_ids = Favorite.get_recipe_ids(@user)
    @recipes = Recipe.search_by_ids(recipe_ids)
  end
end
