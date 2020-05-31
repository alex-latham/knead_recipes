require 'rails_helper'

RSpec.describe User do
  it 'can remove a recipe from their favorite recipes index' do
    VCR.use_cassette("favorites_index_destroy") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Favorite.create(user: user, recipe_id: 4584)
      Favorite.create(user: user, recipe_id: 4514)

      user.reload

      visit favorites_path

      expect(user.favorites.length).to eq(2)

      within('#recipe-4584') do
        click_button 'Delete'
      end

      user.reload

      expect(user.favorites.length).to eq(1)
    end
  end

  it 'can remove a recipe from a favorite recipe show' do
    VCR.use_cassette("favorites_show_destroy") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      Favorite.create(user: user, recipe_id: 4584)

      user.reload

      visit recipe_path(4584)

      click_button 'Delete from Favorites'

      user.reload

      expect(user.favorites.length).to eq(0)
    end
  end
end