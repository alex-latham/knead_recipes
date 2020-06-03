class Recipe
  attr_reader :id,
              :title,
              :image,
              :time,
              :ingredients,
              :instructions,
              :nutrition

  def initialize(recipe)
    @id = recipe[:id]
    @title = recipe[:title]
    @image = recipe[:image]
    @time = recipe[:time]
    @diets = recipe[:diets]
    @summary = recipe[:summary]
    @ingredients = get_ingredients(recipe[:ingredients])
    @instructions = get_instructions(recipe[:instructions])
    @nutrition = get_nutrition(recipe[:nutrition])
  end

  def self.search(search_params)
    recipes = SpoonacularService.new.complex_search(search_params)
    return nil if recipes.nil?

    recipes.map do |recipe|
      Recipe.new(recipe)
    end
  end

  def self.search_by_id(recipe_id)
    recipe = SpoonacularService.new.search_by_id(recipe_id)
    return nil if recipe.nil?

    Recipe.new(recipe)
  end

  def self.search_by_ids(recipe_ids)
    return nil if recipe_ids.empty?

    recipes = SpoonacularService.new.search_by_ids(recipe_ids)
    return nil if recipes.nil?

    recipes.map do |recipe|
      Recipe.new(recipe)
    end
  end

  private

  def get_ingredients(ingredients)
    RecipeIngredient.new(ingredients)
  end

  def get_instructions(instructions)
    RecipeInstructions.new(instructions)
  end

  def get_nutrition(nutrition)
    RecipeNutrition.new(nutrition)
  end
end
