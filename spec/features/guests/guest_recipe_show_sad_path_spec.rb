require 'rails_helper'

RSpec.describe User do
  it 'cannot view a recipe with an invalid id' do
    VCR.use_cassette("invalid_recipe_id") do
      visit guest_recipe_path(5847932)

      expect(page).to have_content("Sorry, we couldn't find any recipes with that ID. Here are some random recipes you might like.")
      expect(page).to have_current_path(guest_recipes_path)
    end
  end
end
