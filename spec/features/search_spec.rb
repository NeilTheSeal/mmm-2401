require "rails_helper"

RSpec.describe "Search", type: :feature do
  it "can search for a food" do
    VCR.use_cassette("search", serialize_with: :json) do |cassette|
      visit root_path

      fill_in :q, with: "sweet potatoes"
      click_button "Search"

      expect(page).to have_current_path(
        foods_path,
        ignore_query: true
      )

      expect(page.status_code).to eq 200

      body = JSON.parse(
        cassette.serializable_hash.dig(
          "http_interactions", 0, "response", "body", "string"
        ),
        symbolize_names: true
      )

      foods = body[:foods]

      within "#results-count" do
        expect(page).to have_content("#{body[:totalHits]} results found.")
      end

      within "#results" do
        expect(page).to have_css("li", count: 10)
        foods.each do |food|
          expect(page).to have_content(food[:description])
          expect(page).to have_content(food[:brandOwner])

          unless food[:ingredients].nil?
            expect(page).to have_content(food[:ingredients])
          end

          expect(page).to have_content(food[:gtinUpc])
        end
      end
    end
  end
end
