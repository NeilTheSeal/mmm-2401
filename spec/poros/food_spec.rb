require "rails_helper"

RSpec.describe Food do
  it "exists" do
    attrs = {
      description: "Sweet Potatoes",
      gtinUpc: "492111402857",
      brandOwner: "FreshDirect",
      ingredients: "Sweet Potatoes"
    }

    food = Food.new(attrs)

    expect(food).to be_a(Food)
    expect(food.description).to eq("Sweet Potatoes")
    expect(food.gtin_upc).to eq("492111402857")
    expect(food.brand_owner).to eq("FreshDirect")
    expect(food.ingredients).to eq("Sweet Potatoes")
  end
end
