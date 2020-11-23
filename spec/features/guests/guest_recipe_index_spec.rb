require "rails_helper"

describe "recipes controller" do
  it "can display up to 10 recipes on index page" do
    VCR.use_cassette("pork_time_120_main_course_10_results") do
      visit guest_home_path
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='120']").click
      find(:xpath, "//input[@value='main course']").click
      click_on "Search Recipes"
      expect(page).to have_current_path("/guest/recipes?ingredients=pork&time=120&type=main+course")
      expect(page).to have_css('.recipes', count: 12)
    end
  end

  it "can view a recipes show page from an image/title link" do
    VCR.use_cassette("pork_time_120_main_course_10_results") do
      visit guest_home_path
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='120']").click
      find(:xpath, "//input[@value='main course']").click
      click_on "Search Recipes"
    end
  end
end
