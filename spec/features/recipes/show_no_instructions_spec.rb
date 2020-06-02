require 'rails_helper'

RSpec.describe User do
  it 'can view a recipe' do
    VCR.use_cassette("no_instructions_recipe") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit recipe_path(30342)

      expect(page).to have_content('Roasted Curried Cauliflower')
      expect(page).to have_button('Favorite')
      expect(page).to have_css("img[src*='https://spoonacular.com/recipeImages/30342-556x370.jpg']")
      expect(page).to have_content('Prep time: 45 minutes')

      within('#ingredients') do
        expect(page).to have_content('Ingredients')
        expect(page).to have_content('1 1/2 cup chickpeas (1 can, drained and rinsed)')
        expect(page).to have_content('1 medium cauliflower (about 2 lbs), cut into florets')
      end

      within('#instructions') do
        expect(page).to have_content('Instructions:')
        expect(page).to have_content('Instructions are unavailable for this recipe.')
      end

      within('#nutrition') do
        expect(page).to have_text('Nutrition Information:')
        expect(page).to have_content('997.25 calories')
        expect(page).to have_content('78.15 g fat')
      end
    end
  end
end
