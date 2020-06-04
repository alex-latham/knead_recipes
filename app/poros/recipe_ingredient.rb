class RecipeIngredient
  attr_reader :list, :missing_ingredients

  def initialize(ingredients)
    @list = ingredient_list(ingredients)
    @missing_ingredients = ingredients[:missing_ingredients]
  end

  private

  def ingredient_list(ingredients)
    ingredients[:ingredients].reduce([]) do |acc, ingredient|
      acc << ingredient[:detailed_name]
    end
  end
end
