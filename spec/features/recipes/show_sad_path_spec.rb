require 'rails_helper'

RSpec.describe User do
  it 'cannot view a recipe with an invalid id' do
    VCR.use_cassette("invalid_recipe_id") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit recipe_path(5847932)

      expect(page).to have_content("Sorry, we couldn't find any recipes with that ID. Here are some random recipes you might like.")
      expect(page).to have_current_path(recipes_path)
    end
  end
end