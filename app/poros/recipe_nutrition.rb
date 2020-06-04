class RecipeNutrition
  attr_reader :calories,
              :protein,
              :fat,
              :carbohydrates,
              :cholesterol,
              :sodium,
              :sugar

  def initialize(nutrition_info)
    @calories = nutrition_info[:calories]
    @protein = nutrition_info[:protein]
    @fat = nutrition_info[:fat]
    @carbohydrates = nutrition_info[:carbohydrates]
    @cholesterol = nutrition_info[:cholesterol]
    @sodium = nutrition_info[:sodium]
    @sugar = nutrition_info[:sugar]
  end
end
