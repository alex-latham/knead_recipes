require 'rails_helper'

describe 'as a user when I visit my profile' do
  it 'there is a link to edit my profile' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    expect(page).to have_link('Edit Profile', href: profile_edit_path)
  end

  it 'I can set my dietary preferences and they will stay checked when I revisit' do
    user = create(:user)
    user.restrictions.create(name: 'vegetarian')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_edit_path

    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_content user.bio
    expect(page).to have_content user.username

    check 'vegetarian'
    check 'gluten_free'

    click_button "Update Profile"

    expect(current_path).to eq profile_path

    expect(page).to have_content("Profile Successfully Updated")
    expect(page).to have_content("Vegetarian")
    expect(page).to have_content("Gluten free")

    visit profile_edit_path

    expect(page).to have_field(:vegetarian, checked: true)
    expect(page).to have_field(:gluten_free, checked: true)
    expect(page).to have_field(:dairy_free, checked: false)
    expect(page).to have_field(:ketogenic, checked: false)
  end

  it 'can also update my bio/information' do
    user = create(:user, bio: "It was all a dream, I used to read word up magazine")
    old_bio = user.bio

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_edit_path

    expect(page).to have_content(user.username)

    fill_in 'bio', with: "I'm blowin' up like you thought I would, call the crib same number same hood it's all good"
    fill_in 'username', with: 'newusername'

    click_button "Update Profile"

    expect(current_path).to eq profile_path

    expect(page).to have_content("Profile Successfully Updated")

    expect(page).to_not have_content(old_bio)
    expect(page).to have_content(user.bio)
    expect(page).to have_content('newusername')
    expect(page).to have_css("img[src*='https://i.kym-cdn.com/photos/images/newsfeed/001/076/734/879.jpg']")
  end

  it 'by default I do not have any dietary restrictions or bio' do
    user = User.create(name: "Paisley McFarney",
                       email: "MCPaisley@worldofplumbus.com")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_content "You can update your bio within Edit Profile"
    expect(page).to have_content "You have no dietary restrictions selected"
  end
end
