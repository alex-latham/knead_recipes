require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:recipe_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end
end