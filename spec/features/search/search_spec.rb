require "rails_helper"

describe "visitors" do
  it "can't use the search function without logging in" do
    visit "/"
    expect(page).to have_content("Log In With Google")
    expect(page).to have_no_content("Search Recipes")
  end
end

describe "searching recipes" do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "can search recipes by an ingredient" do
    VCR.use_cassette('apples_cinnamon_vegetarian_time_15_dessert_3_results') do
      visit "/"
      fill_in :ingredients, with: "apples, cinnamon"
      find(:xpath, "//input[@value='vegetarian']").click
      find(:xpath, "//input[@value='15']").click
      find(:xpath, "//input[@value='dessert']").click

      click_on "Search Recipes"
      expect(page).to have_current_path("/recipes?diet%5B%5D=vegetarian&ingredients=apples%2C+cinnamon&time=15&type=dessert")
      expect(page).to have_css('.recipes', count: 3)
    end
  end

  it "can search for recipes without any fields" do
    VCR.use_cassette("no_params") do
      visit "/"
      click_on "Search Recipes"
      expect(page).to have_css('.recipes', count: 10)
    end
  end

  it "doesn't return recipes with contradicting parameters" do
    VCR.use_cassette("pork_vegetarian") do
      visit "/"
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='vegetarian']").click
      click_on "Search Recipes"

      expect(page).to have_content("Sorry, we couldn't find any recipes matching your specification. Here's some random recipes you might like.")
      expect(page).to have_css('.recipes', count: 10)
    end
  end
end
