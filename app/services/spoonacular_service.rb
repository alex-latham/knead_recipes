class SpoonacularService
  def complex_search(search_params)
    get_json('/recipes/complexSearch', search_params)
  end

  def search_by_id(recipe_id)
    get_json("/recipe/#{recipe_id}")
  end

  def search_by_ids(recipe_ids)
    params = { ids: recipe_ids }
    get_json('/recipes', params)
  end

  private

  def conn
    Faraday.new(url: ENV['MICROSERVICE_URL'])
  end

  def get_json(url, params = nil)
    response = conn.get(url, params)
    require "pry"; binding.pry
    return nil if response.body.empty?

    JSON.parse(response.body, symbolize_names: true)
  end
end
