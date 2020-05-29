require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'relationships' do
    it { should have_many(:favorites) }
    it { should have_many(:user_restrictions) }
    it { should have_many(:restrictions).through(:user_restrictions) }
    it { should have_many(:friendships) }
  end

  describe 'class methods' do
    it 'can create a user from google Omniauth' do
      user = build(:user)

      expect(User.count).to eq(0)

      OmniAuth.config.test_mode = true

      hash = OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        :provider => 'google_oauth2',
        :info => { name: user.name,
                   email: user.email
                 }
          })

      new_user = User.from_omniauth(hash)
      expect(new_user.name).to eq(user.name)
      expect(new_user.email).to eq(user.email)

      expect(User.count).to eq(0)
    end

    it 'can find a user from google Omniauth' do
      user = create(:user)

      expect(User.count).to eq(1)

      OmniAuth.config.test_mode = true

      hash = OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        :provider => 'google_oauth2',
        :info => { name: user.name,
                   email: user.email
                 }
          })

      found_user = User.from_omniauth(hash)
      expect(found_user.name).to eq(user.name)
      expect(found_user.email).to eq(user.email)

      expect(User.count).to eq(1)
    end
  end
end
