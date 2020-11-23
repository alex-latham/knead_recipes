require "rails_helper"

RSpec.describe 'as a guest I can log in' do
  it 'I can log in as a guest' do

    expect(User.count).to eq(0)

    visit root_path

    click_link 'Continue as Guest'

    expect(page).to have_content("Logged in as Guest")

    expect(current_path).to eq(root_path)

    expect(page).to_not have_link 'Log In With Google'

    expect(User.count).to eq(0)
  end

  it 'has limited nav bar functionality' do
    visit root_path

    click_link 'Continue as Guest'

    expect(current_path).to eq(root_path)

    expect(page).to_not have_link 'Profile'
    expect(page).to_not have_link 'Friends'
    expect(page).to_not have_link 'Favorites'
    expect(page).to have_content('INGREDIENTS')
    expect(page).to have_content('PREP TIME')
    expect(page).to have_button('Search Recipes')
  end

  it 'guests do not have a profile' do
    visit '/profile'

    expect(page).to_not have_css("user-name")
    expect(page).to_not have_css("user-bio")
    expect(page).to_not have_css("user-email")
    expect(page).to_not have_link("Edit Profile")
    expect(page).to_not have_link("Favorites")
    expect(page).to_not have_link("Friends")
    expect(page).to have_content("404")
  end
end
