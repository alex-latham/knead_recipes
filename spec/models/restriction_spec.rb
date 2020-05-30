require 'rails_helper'

RSpec.describe Restriction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:user_restrictions) }
    it { should have_many(:users).through(:user_restrictions) }
  end
end
