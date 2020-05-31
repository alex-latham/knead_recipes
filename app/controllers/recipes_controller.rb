class RecipesController < ApplicationController
  def index
    recipes = SpoonacularService.new(search_params).parse_recipes
    @recipes = recipes[:results].map do |recipe_json|
      Recipe.new(recipe_json)
    end
    if @recipes.empty?
      flash['alert alert-danger'] = "Sorry, we couldn't find any recipes matching your
      specification. Here's some random recipes you might like."
      redirect_to '/recipes'
    end
  end

  def show; end

  private

  def search_params
    params.permit(:ingredients,
                  :time,
                  :type,
                  diet: [])
  end
end
