require 'rails_helper'

describe 'as a user when I visit my profile' do
  it 'there is a link to edit my profile' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    click_link "Edit Profile"
      expect(current_path).to eq(profile_edit_path)

    visit profile_path
  end

  it 'I can see my current dietary preferences' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_edit_path

    expect(page).to have_content user.name

    expect(page).to have_content user.email

    check 'vegetarian'
    check 'gluten_free'

    click_button "Update Profile"

    expect(current_path).to eq profile_path
    expect(page).to have_content("vegetarian")
  end
end
