require rails_helper

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
end
