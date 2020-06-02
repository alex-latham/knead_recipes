require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:recipe_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'methods' do
    it 'self.get_recipe_ids(user)' do
      user = create(:user)
      Favorite.create(user: user, recipe_id: 12345)
      Favorite.create(user: user, recipe_id: 12245)

      expect(Favorite.get_recipe_ids(user)).to eq('12345,12245')
    end
  end
end