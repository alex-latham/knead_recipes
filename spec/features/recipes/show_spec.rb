require 'rails_helper'

RSpec.describe User do
  it 'can view a recipe' do
    VCR.use_cassette("salmon_recipe") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit recipe_path(4584)

      expect(page).to have_content('Blackened Salmon With Hash Browns and Green Onions')
      expect(page).to have_button('Add to Favorites')
      expect(page).to have_css("img[src*='https://spoonacular.com/recipeImages/4584-556x370.jpg']")
      expect(page).to have_content('Prep time: 41 minutes')

      within('#ingredients') do
        expect(page).to have_content('Ingredients')
        expect(page).to have_content('Garnish: fresh dill sprigs')
        expect(page).to have_content('1 tablespoon chopped fresh or 1 teaspoon dried dill')
      end

      within('#instructions') do
        expect(page).to have_content('Instructions:')
        expect(page.all('li')[0]).to have_content('Remove and discard root ends and 1 inch of top green portions of green onions, and set green onions aside.')
        expect(page.all('li')[1]).to have_content('Toss together hash browns, dill, and salt in a large bowl.')
      end

      within('#nutrition') do
        expect(page).to have_text('Nutrition Information:')
        expect(page).to have_content('629.42 calories')
        expect(page).to have_content('26.77 g fat')
      end
    end
  end
end