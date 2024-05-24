require "rails_helper"

RSpec.describe SearchService do
  it "returns a list of results" do
    VCR.use_cassette("search_service", serialize_with: :json) do |_cassette|
      response = SearchService.search("sweet potatoes")

      expect(response).to be_a(Hash)
      expect(response).to have_key(:totalHits)
      expect(response).to have_key(:foods)
      expect(response[:foods]).to be_an(Array)

      foods = response[:foods]

      expect(foods.count).to be(10)

      foods.each do |food|
        expect(food).to have_key(:description)
        expect(food).to have_key(:gtinUpc)
        expect(food).to have_key(:brandOwner)
        expect(food).to have_key(:ingredients)
      end
    end
  end
end
