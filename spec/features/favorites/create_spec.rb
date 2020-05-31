require 'rails_helper'

RSpec.describe User do
  it 'can view a recipe' do
    VCR.use_cassette("salmon_recipe_2") do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit recipe_path(4584)

      expect(user.favorites.length).to eq(0)

      click_button('Favorite')
      expect(page).to have_content('This recipe has been added to your favorites')

      user.reload

      expect(user.favorites.length).to eq(1)
      expect(user.favorites.first.recipe_id).to eq(4584)
    end
  end
end