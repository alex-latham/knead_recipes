require 'rails_helper'

RSpec.describe User do
  it 'can view their favorite recipes' do
    VCR.use_cassette("favorites") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Favorite.create(user: user, recipe_id: 4584)
      Favorite.create(user: user, recipe_id: 4514)

      user.reload

      visit profile_favorites_path

      within('#recipe-4584') do
        expect(page).to have_link('Blackened Salmon With Hash Browns and Green Onions', href: recipe_path(4584))
        expect(page).to have_css("img[src*='https://spoonacular.com/recipeImages/4584-556x370.jpg']")
      end

      within('#recipe-4514') do
        expect(page).to have_link('Salmon With Honey-coriander Glaze', href: recipe_path(4514))
        expect(page).to have_css("img[src*='https://spoonacular.com/recipeImages/4514-556x370.jpg']")
      end
    end
  end

  it 'is told when they have no favorites' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_favorites_path

    expect(page).to have_content('You have not favorited any recipes.')
  end

  it "can view others' favorite recipes" do
    VCR.use_cassette("others' favorites") do
      user1 = create(:user)
      user2 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      Favorite.create(user: user2, recipe_id: 4584)
      Favorite.create(user: user2, recipe_id: 4514)

      user2.reload

      visit user_favorites_path(user2.username)

      within('#recipe-4584') do
        expect(page).to have_link('Blackened Salmon With Hash Browns and Green Onions', href: recipe_path(4584))
        expect(page).to have_css("img[src*='https://spoonacular.com/recipeImages/4584-556x370.jpg']")
      end

      within('#recipe-4514') do
        expect(page).to have_link('Salmon With Honey-coriander Glaze', href: recipe_path(4514))
        expect(page).to have_css("img[src*='https://spoonacular.com/recipeImages/4514-556x370.jpg']")
      end
    end
  end
end