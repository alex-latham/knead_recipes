require "rails_helper"

describe "searching recipes" do
  it "can search recipes by an ingredient" do
    VCR.use_cassette('apples_cinnamon_vegetarian_time_15_dessert_3_results') do
      visit "/search"
      fill_in :ingredients, with: "apples, cinnamon"
      find(:xpath, "//input[@value='vegetarian']").click
      find(:xpath, "//input[@value='15']").click
      find(:xpath, "//input[@value='dessert']").click

      click_on "Search Recipes"
      expect(page).to have_current_path("/recipes?diet%5B%5D=vegetarian&ingredients=apples%2C+cinnamon&time=15&type=dessert")
      within(".recipes") do
        expect(page).to have_css('.recipe-image', count: 3)
      end
    end
  end

  it "can search for recipes without any fields" do
    VCR.use_cassette("no_params") do
      visit "/search"
      click_on "Search Recipes"
      within(".recipes") do
        expect(page).to have_css('.recipe-image', count: 10)
      end
    end
  end

  it "doesn't return recipes with contradicting parameters" do
    VCR.use_cassette("pork_vegetarian") do
      visit "/search"
      fill_in :ingredients, with: "pork"
      find(:xpath, "//input[@value='vegetarian']").click
      click_on "Search Recipes"

      expect(page).to have_content("Sorry, we couldn't find any matching your specification. Here's some random recipes you might like.")
      expect(page).to have_css('.recipe-image', count: 10)
      expect(page).to have_css('.recipe-title', count: 10)
    end
  end
end
