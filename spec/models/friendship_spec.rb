require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end