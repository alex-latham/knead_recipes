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

  it 'has my information and links to edit info, my favorites, and my friends' do
    user = create(:user, bio: "Livin' life without fear, puttin' five carats in my baby girl ear")

    expect(User.count).to eq(1)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :info => { name: user.name,
                 email: user.email
               }
        })

    visit root_path

    click_link 'Log In With Google'

    expect(current_path).to eq(root_path)

    click_on "Menu"

    click_link "Profile"

    expect(current_path).to eq(profile_path)

    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_content user.bio
    expect(page).to have_link("Edit Profile")
    expect(page).to have_link("Favorites")
    expect(page).to have_link("Friends")
  end

  it 'has links to edit my profile, my favorites, and my friends' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    click_link "Edit Profile"
      expect(current_path).to eq(profile_edit_path)
      
    # We will need to test these links but functionality is not built in for them yet
    # visit profile_path
    #
    # click_link "Favorites"
    #   expect(current_path).to eq(favorites_path)
    #
    # visit profile_path
    #
    # click_link "Friends"
    #   expect(current_path).to eq(friends_path)
  end
end
