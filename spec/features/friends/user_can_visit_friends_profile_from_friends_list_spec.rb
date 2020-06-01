require 'rails_helper'

describe "As a user" do
  it "I can see a friends profile from my friends list" do
    user_1 = User.create!(name: "F", email: "F@example.com", bio: "Fun Guy", username: '321')
    user_2 = User.create!(name: "G", email: "G@example.com", bio: "Also a Fun Guy", username: '123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit profile_friends_path
    fill_in :email_address, with: user_2.email
    click_button "Add Friend"

    expect(page).to have_link(user_2.email)

    click_link(user_2.email)

    expect(page).to have_content(user_2.name)
    expect(page).to have_content(user_2.email)
    expect(page).to have_content(user_2.bio)
    expect(page).to have_link("#{user_2.name}'s Favorites")
  end
end
