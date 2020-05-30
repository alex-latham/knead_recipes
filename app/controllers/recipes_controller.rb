class RecipesController < ApplicationController
  def index
    params = format_params
    connection = Faraday.new(url: 'https://api.spoonacular.com/',
                             params: request_params)
    request = connection.get('/recipes/complexSearch')
    @recipes = JSON.parse(request.body, symbolize_names: true)
  end

  private

  def request_params
    { apiKey: ENV['SPOONACULAR_KEY'],
      addRecipeInformation: true,
      includeIngredients: params['ingredients'],
      fillIngredients: true, ignorePantry: true,
      maxReadyTime: params['time'], diet: params['diet'], type: params['type'],
      minCalories: 0,
      minFat: 0, minProtein: 0, minCarbs: 0, minSugar: 0, minSodium: 0,
      minCholesterol: 0,
      number: 10, sort: 'random' }.compact
  end

  def search_params
    params.permit(:ingredients,
                  :time,
                  :type,
                  :vegetarian,
                  :keto,
                  'dairy free',
                  'gluten free',
                  :vegan)
  end

  def format_params
    params = search_params.to_h.each_with_object({}) do |(key, value), acc|
      if value == 'true'
        acc['diet'].nil? ? acc['diet'] = [key] : acc['diet'] << key
      else
        key == 'time' ? acc[key] = value.to_i : acc[key] = value
      end
    end
    params['diet'] = params['diet'].join(',') unless params['diet'].nil?
    params
  end
end
