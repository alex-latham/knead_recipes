require 'rails_helper'

describe 'as a registered user I have a login page' do
  it 'is not visible if I am not logged in' do
    visit '/profile'

    expect(page).to_not have_css("user-name")
    expect(page).to_not have_css("user-bio")
    expect(page).to_not have_css("user-email")
    expect(page).to_not have_link("Edit Profile")
    expect(page).to_not have_link("Favorites")
    expect(page).to_not have_link("Freinds")
    expect(page).to have_content("404")
  end

  # it 'can be seen when I log in via oauth' do
  #
  # end

  it 'has my information and links to edit info, my favroties, and my friends' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/profile'

    expect(page).to have_content("User Profile")

    # expect(page).to_not have_css("user-name")
    # expect(page).to_not have_css("user-bio")
    # expect(page).to_not have_css("user-email")
    # expect(page).to_not have_link("Edit Profile")
    # expect(page).to_not have_link("Favorites")
    # expect(page).to_not have_link("Freinds")
  end
end


# As a logged in user
# I can click on my profile picture
# And my path is "/profile"
# I see my Google Username and Email
# And I see tabs to edit my profile info, favorites, friends
