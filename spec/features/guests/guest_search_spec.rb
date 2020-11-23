require "rails_helper"

describe "searching recipes" do
  it "can search recipes by an ingredient" do
    visit guest_home_path
    fill_in :ingredients, with: "apples, cinnamon"
    find(:xpath, "//input[@value='vegetarian']").click
    find(:xpath, "//input[@value='15']").click
    find(:xpath, "//input[@value='dessert']").click

    click_on "Search Recipes"
    expect(page).to have_current_path("guest/recipes?diet=vegetarian&ingredients=apples%2C+cinnamon&time=15&type=dessert")
    expect(page).to have_css('.recipes', count: 3)
  end

  # it "can search for recipes without any fields" do
  #   VCR.use_cassette("no_params") do
  #     visit "/"
  #     click_on "Search Recipes"
  #     expect(page).to have_css('.recipes', count: 12)
  #   end
  # end
  #
  # it "doesn't return recipes with contradicting parameters" do
  #   VCR.use_cassette("pork_vegetarian_0_results") do
  #     visit "/"
  #     fill_in :ingredients, with: "pork"
  #     find(:xpath, "//input[@value='vegetarian']").click
  #     click_on "Search Recipes"
  #
  #     expect(page).to have_content("Sorry, we couldn't find any recipes matching your specification. Here are some random recipes you might like.")
  #     expect(page).to have_css('.recipes', count: 12)
  #   end
  # end
end
