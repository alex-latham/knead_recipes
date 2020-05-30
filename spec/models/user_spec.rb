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
      it "add_friend Creates a new friendship between users" do
        user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy")
        user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy")
        expect(user_1.friendships).to eq([])
        expect(user_2.friendships).to eq([])
        user_1.add_friend(user_2.email)
        user_1.reload
        user_2.reload
        expect(user_1.friendships.length).to eq(1)
        expect(user_2.friendships.length).to eq(1)
      end

      it "add_friend returns false when presented email address of current friend" do
        user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy")
        user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy")
        user_1.add_friend(user_2.email)
        user_1.reload
        user_2.reload
        expect(user_1.add_friend(user_2.email)).to eq(false)
      end

      it "add_friend returns false when given invalid email address" do
        user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy")
        expect(user_1.add_friend("asdf")).to eq(false)
      end

      it "load_friends returns all friendships as user objects" do
        user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy")
        user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy")
        user_1.add_friend(user_2.email)
        user_1.reload
        user_2.reload
        expect(user_1.load_friends).to eq([user_2])
      end

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