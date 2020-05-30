class RecipeNutrition
  attr_reader :calories,
              :protein,
              :fat,
              :carbohydrates,
              :cholesterol,
              :sodium,
              :sugar

  def initialize(nutrition_json)
    @calories = format_nutrition(nutrition_json[0])
    @protein = format_nutrition(nutrition_json[1])
    @fat = format_nutrition(nutrition_json[2])
    @carbohydrates = format_nutrition(nutrition_json[3])
    @cholesterol = format_nutrition(nutrition_json[4])
    @sodium = format_nutrition(nutrition_json[5])
    @sugar = format_nutrition(nutrition_json[6])
  end

  private

  def format_nutrition(nutrition_json)
    { nutrition_json[:amount] => nutrition_json[:title] }
  end
end
