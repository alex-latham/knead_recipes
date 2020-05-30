class RecipesController < ApplicationController
  def index
    connection = Faraday.new(url: 'https://api.spoonacular.com/',
                             params: request_params)
    request = connection.get('/recipes/complexSearch')
    @recipes = JSON.parse(request.body, symbolize_names: true)
    if @recipes[:totalResults] == 0
      flash[:error] = "Sorry, we couldn't find any matching your specification. Here's some random recipes you might like."
      redirect_to "/recipes"
    end
  end

  private

  def request_params
    { apiKey: ENV['SPOONACULAR_KEY'],
      addRecipeInformation: true,
      includeIngredients: format_params['ingredients'],
      fillIngredients: true, ignorePantry: true,
      maxReadyTime: format_params['time'], diet: format_params['diet'],
      type: format_params['type'],
      minCalories: 0, minCholesterol: 0,
      minFat: 0, minProtein: 0, minCarbs: 0, minSugar: 0, minSodium: 0,
      number: 10, sort: 'random' }.compact
  end

  def search_params
    params.permit(:ingredients,
                  :time,
                  :type,
                  :diet => [])
  end

  def format_params
    search_params.to_h.each_with_object({}) do |(key, value), acc|
      if key == 'diet'
        acc[key] = value.join(',')
      else
        key == 'time' ? acc[key] = value.to_i : acc[key] = value
      end
    end
  end
end
