require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:bio) }
  end

  describe 'relationships' do
    it { should have_many(:favorites) }
    it { should have_many(:user_restrictions) }
    it { should have_many(:restrictions).through(:user_restrictions) }
    it { should have_many(:friendships) }
  end

  describe 'methods' do
    describe "add_friend" do
      it "Creates a new friendship between users" do
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
    end

    describe "load_friends" do
      it "Returns all friendships and user objects" do
        user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy")
        user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy")
        user_1.add_friend(user_2.email)
        user_1.reload
        user_2.reload
        expect(user_1.load_friends).to eq([user_2])
      end
    end
  end
end
