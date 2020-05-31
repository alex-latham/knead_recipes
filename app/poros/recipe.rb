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

  def self.search(search_params)
    recipes_json = SpoonacularService.new.complex_search(search_params)
    recipes_json[:results].map do |recipe_json|
      Recipe.new(recipe_json)
    end
  end

  def self.search_by_id(id)
    recipe_json = SpoonacularService.new.search_by_id(id)
    recipe_json[:nutrition] = recipe_json[:nutrition][:nutrients]
    Recipe.new(recipe_json)
  end

  private

  def get_ingredients(recipe_json)
    RecipeIngredient.new(recipe_json)
  end

  def get_instructions(instructions_json)
    RecipeInstructions.new(instructions_json)
  end

  def get_nutrition(nutrition_json)
    RecipeNutrition.from_json(nutrition_json)
  end
end
