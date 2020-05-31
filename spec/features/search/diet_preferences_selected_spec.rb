require 'rails_helper'

describe 'user preferences in search' do
  it 'will automatically select my dietary preferences' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    veg = find(:xpath, "//input[@value='vegetarian']")
    vegan = find(:xpath, "//input[@value='vegan']")
    dairy = find(:xpath, "//input[@value='dairy free']")

    expect(veg).to_not be_checked
    expect(vegan).to_not be_checked
    expect(dairy).to_not be_checked

    veggie = Restriction.create(name: 'vegetarian')
    gf = Restriction.create(name: 'gluten_free')
    user.restrictions << veggie
    user.restrictions << gf

    dairy.click

    expect(veg).to_not be_checked
    expect(vegan).to_not be_checked
    expect(dairy).to be_checked
  end
end
