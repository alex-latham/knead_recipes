class SpoonacularService
  def initialize(params)
    @params = format_params(params)
  end

  def parse_recipes
    connection = Faraday.new(url: 'https://api.spoonacular.com/',
                             params: request_params)
    request = connection.get('/recipes/complexSearch')
    JSON.parse(request.body, symbolize_names: true)
  end

  def request_params
    { apiKey: ENV['SPOONACULAR_KEY'],
      addRecipeInformation: true,
      includeIngredients: @params['ingredients'],
      fillIngredients: true, ignorePantry: true,
      maxReadyTime: @params['time'], diet: @params['diet'],
      type: @params['type'],
      minCalories: 0, minCholesterol: 0,
      minFat: 0, minProtein: 0, minCarbs: 0, minSugar: 0, minSodium: 0,
      number: 10, sort: 'random' }.compact
  end

  def format_params(params)
    params.to_h.each_with_object({}) do |(key, value), acc|
      if key == 'diet'
        acc[key] = value.join(',')
      elsif key == 'time'
        acc[key] = value.to_i
      else
        acc[key] = value
      end
    end
  end
end
