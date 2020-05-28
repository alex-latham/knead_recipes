require 'rails_helper'

describe "As a user" do
  it "I can add a new friend from /profile/friends" do
    @user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy")
    @user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit "/profile"
    expect(page).to have_link("My Friends")
    click_link ("My Friends")
    expect(current_path).to eq("/profile/friends")

    fill_in "Email Address", with: @user_2.email
    click_button "Add Friend"
    expect(current_path).to eq("/profile/friends")
    expect(page).to have_content("Friend Added Successfully")
    expect(page).to have_content(@user_2.email)
    expect(page).to_not have_content("You have no friends, try adding some :^)")
  end
end
