require_relative 'recipe_ingredient'
require_relative 'recipe_nutrition'
require_relative 'recipe_instructions'

class Recipe
  attr_reader :id,
              :title,
              :image,
              :time,
              :ingredients,
              :instructions,
              :nutrition

  def initialize(recipe_json)
    @id = recipe_json[:id]
    @title = recipe_json[:title]
    @image = recipe_json[:image]
    @time = recipe_json[:readyInMinutes]
    @ingredients = get_ingredients(recipe_json)
    @instructions = get_instructions(recipe_json[:analyzedInstructions])
    @nutrition = get_nutrition(recipe_json[:nutrition])
  end

  private

  def get_ingredients(ingredient_json)
    RecipeIngredient.new(ingredient_json)
  end

  def get_instructions(instructions_json)
    RecipeInstructions.new(instructions_json)
  end

  def get_nutrition(nutrition_json)
    RecipeNutrition.new(nutrition_json)
  end
end
