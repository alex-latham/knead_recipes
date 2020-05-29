require 'rails_helper'

RSpec.describe 'as a user I can log in' do
  it 'I can connect to Google through OAuth' do

    user = build(:user)

    expect(User.count).to eq(0)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :info => { name: user.name,
                 email: user.email
               }
        })

    visit root_path

    click_link 'Log In With Google'

    expect(page).to have_content("Logged in as #{user.name}")

    expect(current_path).to eq(root_path)

    expect(page).to_not have_link 'Log In With Google'

    expect(User.count).to eq(1)
  end

  it 'knows if a user is already in the system' do
    user = create(:user)

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

    expect(page).to have_content("Logged in as #{user.name}")

    expect(current_path).to eq(root_path)

    expect(User.count).to eq(1)
  end

  it 'can log out' do
    user = create(:user)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :info => { name: user.name,
                 email: user.email
               }
        })

    visit root_path

    click_link 'Log In With Google'

    visit root_path

    click_on "Menu"
    click_link "Logout"

    expect(page).to have_content("You have been successfully logged out.")

    expect(current_path).to eq(root_path)

    expect(page).to have_link("Log In With Google")
  end
end
