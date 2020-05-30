class RecipeIngredient
  attr_reader :list, :missing_ingredients

  def initialize(recipe_json)
    @list = ingredient_list(recipe_json)
    @missing_ingredients = recipe_json[:missedIngredientCount]
  end

  private

  def ingredient_list(recipe_json)
    recipe_json[:extendedIngredients].reduce([]) do |acc, ingredient|
      acc << ingredient[:originalString]
    end
  end
end
