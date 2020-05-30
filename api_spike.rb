require "faraday"
require "json"

ingredients = ["apples", "cinnamon"]
params = { ingredients: ingredients.join(','),
           time_restraint: 60,
           diet_restraint: "vegetarian",
           type_restraint: "dessert" }

def get_recipes(params)
  request = connection(params).get("/recipes/complexSearch")
  JSON.parse(request.body, symbolize_names: true)
end

def connection(params)
  Faraday.new(url: "https://api.spoonacular.com/",
              params: { apiKey: ENV['SPOONACULAR_KEY],
                        addRecipeInformation: true,
                        includeIngredients: params[:ingredients],
                        fillIngredients: true,
                        ignorePantry: true,
                        maxReadyTime: params[:time_restraint],
                        diet: params[:diet_restraint],
                        type: params[:type_restraint],
                        minCalories: 0,
                        minFat: 0,
                        minProtein: 0,
                        minCarbs: 0,
                        minSugar: 0,
                        minSodium: 0,
                        minCholesterol: 0,
                        number: 2,
                        sort: 'random'})
end

class Recipe
  attr_reader :ingredients
  def initialize(recipe_info)
    @id = recipe_info[:id]
    @summary = recipe_info[:summary]
    @name = recipe_info[:title]
    @image = recipe_info[:image]
    @nutrition = RecipeNutrition.new(recipe_info[:nutrition])
    @instructions = RecipeInstruction.new(recipe_info[:analyzedInstructions].first)
    @ingredients = RecipeIngredients.new(recipe_info[:extendedIngredients],
                                         recipe_info[:missedIngredients])
    @dish = recipe_info[:dishTypes]
    @diet = recipe_info[:diets]
    @time = recipe_info[:readyInMinutes]
  end
end

class RecipeNutrition
  def initialize(nutrition_info)
    @calories = nutrition_info[0]
    @protein = nutrition_info[1]
    @fat = nutrition_info[2]
    @carbs = nutrition_info[3]
    @cholesterol = nutrition_info[4]
    @sodium = nutrition_info[5]
    @sugar = nutrition_info[6]
  end
end

class RecipeInstruction
  def initialize(instruction_info)
    @number_of_steps = instruction_info[:steps].length
  end
end

class RecipeIngredients
  def initialize(ingredients_info, missing_ingredients)
    @number_of_ingredients = ingredients_info.length
    @ingredients = get_ingredients(ingredients_info)
    @missing_ingredients = get_ingredients(missing_ingredients)
  end

  def get_ingredients(ingredients)
    ingredients.reduce([]) do |acc, ingredients|
      acc << ingredients[:originalString]
    end
  end
end

response = get_recipes(params)
recipes = response[:results].reduce([]) do |acc, recipe_info|
  acc << Recipe.new(recipe_info)
end
