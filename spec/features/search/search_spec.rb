require "rails_helper"

describe "searching recipes" do
  it "can search recipes by an ingredient" do
    VCR.use_cassette('apples_cinnamon_vegetarian_time_15_dessert_3_results') do
      visit "/search"
      fill_in :ingredients, with: "apples, cinnamon"
      check(:vegetarian)

      find(:xpath, "//input[@value='15']").click
      find(:xpath, "//input[@value='dessert']").click


      click_on "Search Recipes"
      expect(page).to have_current_path("/recipes?ingredients=apples%2C+cinnamon&time=15&type=dessert&vegetarian=true")
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
end
