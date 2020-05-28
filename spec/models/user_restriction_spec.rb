require 'rails_helper'

RSpec.describe UserRestriction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:restriction_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:restriction) }
  end
end