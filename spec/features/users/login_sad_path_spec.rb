require 'rails_helper'

RSpec.describe 'as a user I can log in' do
  it 'I can connect to Google through OAuth' do

    user = build(:user)

    expect(User.count).to eq(0)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :info => { name: nil,
                 email: user.email
               }
        })

    visit root_path

    click_link 'Log In With Google'

    expect(page).to have_content("Name can't be blank")

    expect(current_path).to eq(root_path)

    expect(page).to have_link 'Log In With Google'

    expect(User.count).to eq(0)
  end
end
