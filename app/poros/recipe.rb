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

  def self.search_by_id(recipe_id)
    recipe_json = SpoonacularService.new.search_by_id(recipe_id)
    return nil if recipe_json[:code] == 404

    recipe_json[:nutrition] = recipe_json[:nutrition][:nutrients]
    Recipe.new(recipe_json)
  end

  def self.search_by_ids(recipe_ids)
    return nil if recipe_ids.empty?

    recipes_json = SpoonacularService.new.search_by_ids(recipe_ids)
    recipes_json.map do |recipe_json|
      recipe_json[:nutrition] = recipe_json[:nutrition][:nutrients]
      Recipe.new(recipe_json)
    end
  end

  def self.share_with_friends(user, recipe_mailer_params)
    user.friends.each do |friend|
      email_info = {
        user: user.username,
        friend: friend.username,
        friend_email: friend.email,
        recipe_title: recipe_mailer_params[:title],
        recipe_id: recipe_mailer_params[:id],
      }
      RecipeMailerJob.perform_later(email_info)
    end
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
