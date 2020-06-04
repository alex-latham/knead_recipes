require 'rails_helper'

describe "As a user" do
  it "I can add a new friend from /profile/friends" do
    user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy", username: '321')
    user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy", username: '123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit profile_path

    expect(page).to have_link("My Friends")

    click_link ("My Friends")

    expect(current_path).to eq(profile_friends_path)
    expect(page).to have_content("You can add friends if you know their username!")

    fill_in :username, with: user_2.username
    click_button "Add Friend"

    expect(current_path).to eq(profile_friends_path)
    expect(page).to have_content("Friend Added Successfully")
    expect(page).to have_link(user_2.username, href: user_path(user_2.username))
    expect(page).to_not have_content("You have no friends, try adding some :^)")
  end

  it "I cannot add a friend using an invalid email" do
    user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy", username: '321')
    user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy", username: '123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit profile_friends_path
    fill_in :username, with: "asfasdf"
    click_button "Add Friend"

    expect(page).to_not have_content("Friend Added Successfully")
    expect(page).to have_content("Invalid Email Entered, Try Again")
  end

  it "I cannot add a friend that is already on my friends list" do
    user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy", username: '321')
    user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy", username: '123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit profile_friends_path

    fill_in :username, with: user_2.username
    click_button "Add Friend"

    expect(current_path).to eq(profile_friends_path)
    expect(page).to have_content("Friend Added Successfully")

    fill_in :username, with: user_2.username
    click_button "Add Friend"
    expect(page).to have_content("Invalid Email Entered, Try Again")
  end
end
