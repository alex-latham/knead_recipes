require "rails_helper"

describe "recipes controller" do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "can display up to 10 recipes on index page" do
    VCR.use_cassette("pork_time_120_main_course_10_results") do
      visit "/"
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='120']").click
      find(:xpath, "//input[@value='main course']").click
      click_on "Search Recipes"
      expect(page).to have_current_path("/recipes?ingredients=pork&time=120&type=main+course")
      expect(page).to have_css('.recipes', count: 10)
    end
  end

  it "can view a recipes show page from an image/title link" do
    VCR.use_cassette("pork_time_120_main_course_10_results") do
      visit "/"
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='120']").click
      find(:xpath, "//input[@value='main course']").click
      click_on "Search Recipes"
    end
  end
end
