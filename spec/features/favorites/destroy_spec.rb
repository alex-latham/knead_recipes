require 'rails_helper'

RSpec.describe User do
  it 'can remove a recipe from their favorite recipes' do
    VCR.use_cassette("favorites_destroy") do
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
end