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

  def self.from_json(nutrition_json)
    nutrition_info = nutrition_json.each_with_object({}) do |nutrient_json, acc|
      acc[nutrient_json[:title].downcase.to_sym] = nutrient_json[:amount]
      acc
    end
    RecipeNutrition.new(nutrition_info)
  end
end
