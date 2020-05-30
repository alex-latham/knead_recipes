class RecipesController < ApplicationController
  def index
    @recipes = Recipe.search(search_params)
    return unless @recipes.empty?

    flash[:error] = "Sorry, we couldn't find any recipes matching your
    specification. Here are some random recipes you might like."
    redirect_to recipes_path
  end

  def show; end

  private

  def search_params
    params.permit(:ingredients, :time, :type, :diet)
  end
end
