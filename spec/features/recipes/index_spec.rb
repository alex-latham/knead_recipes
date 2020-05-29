require "rails_helper"

describe "recipes controller" do
  it "can display up to 10 recipes on index page" do
    VCR.use_cassette("pork_time_120_main_course_10_results") do
      visit "/search"
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='120']").click
      find(:xpath, "//input[@value='main course']").click
      click_on "Search Recipes"
      expect(page).to have_current_path("/recipes?ingredients=pork&time=120&type=main+course")
      within(".recipes") do
        expect(page).to have_css('.recipe-image', count: 10)
        expect(page).to have_css('.recipe-title', count: 10)
      end
    end
  end

  it "can view a recipes show page from an image/title link" do
    VCR.use_cassette("pork_time_120_main_course_10_results") do
      visit "/search"
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='120']").click
      find(:xpath, "//input[@value='main course']").click
      click_on "Search Recipes"

      within(".recipes") do
      end
    end
  end
end
