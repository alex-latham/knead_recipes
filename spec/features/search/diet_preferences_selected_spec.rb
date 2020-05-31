require 'rails_helper'

describe 'user preferences in search' do
  it 'will automatically select my dietary preferences' do
    user = create(:user)
    dairy_free = Restriction.create(name: 'dairy free')
    vegan = Restriction.create(name: 'vegan')

    user.restrictions << dairy_free
    user.restrictions << vegan

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    veg = find(:xpath, "//input[@value='vegetarian']")
    vegan = find(:xpath, "//input[@value='vegan']")
    dairy = find(:xpath, "//input[@value='dairy free']")

    expect(veg).to_not be_checked
    expect(vegan).to be_checked
    expect(dairy).to be_checked
  end
end
