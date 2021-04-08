require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
  end

  describe "class methods" do
    describe "::find_by_name" do
      it "returns a record that contains a given name and is sorted alphabetically" do
        merchant = create(:merchant)
        gold_ring = create(:item, merchant_id: merchant.id, name: "Gold Ring" )
        silver_ring = create(:item, merchant_id: merchant.id, name: "Awesome Silver Ring")
        diamond_ring = create(:item, merchant_id: merchant.id, name: "Diamond Ring")
        name = "ring"
        expect(Item.find_by_name(name)[0]).to eq(silver_ring)
      end
      it "the search handles case sensitive searches" do
        merchant = create(:merchant)
        gold_ring = create(:item, merchant_id: merchant.id, name: "Gold Ring" )
        silver_ring = create(:item, merchant_id: merchant.id, name: "Awesome Silver ring")
        diamond_ring = create(:item, merchant_id: merchant.id, name: "Diamond RING")
        name = "riNG"
        expect(Item.find_by_name(name).length).to eq(3)
        expect(Item.find_by_name(name).first).to eq(silver_ring)
        expect(Item.find_by_name(name).second).to eq(diamond_ring)
        expect(Item.find_by_name(name).third).to eq(gold_ring)
      end
    end
    describe "::find_by_min_price" do
      it "returns an item list where the unit_price is more than min price given and sorted alphabetically" do
        merchant = create(:merchant)
        gold_ring = create(:item, merchant_id: merchant.id, name: "Gold Ring", unit_price: 749.00)
        silver_ring = create(:item, merchant_id: merchant.id, name: "Silver Ring", unit_price: 200.99)
        mood_ring = create(:item, merchant_id: merchant.id, name: "Mood Ring", unit_price: 49.99)
        diamond_necklace = create(:item, merchant_id: merchant.id, name: "Diamond Necklace", unit_price: 2100.99)
        min_price = 300.0

        expect(Item.find_by_min_price(min_price).first).to eq(diamond_necklace)
        expect(Item.find_by_min_price(min_price).length).to eq(2)
        expect(Item.find_by_min_price(min_price).first.unit_price).to be > min_price
        expect(Item.find_by_min_price(min_price).second.unit_price).to be > min_price
      end
    end
    describe "::find_by_max_price" do
      it "returns an item list where the unit_price is less than max price given and sorted alphabetically" do
        merchant = create(:merchant)
        gold_ring = create(:item, merchant_id: merchant.id, name: "Gold Ring", unit_price: 749.00)
        silver_ring = create(:item, merchant_id: merchant.id, name: "Silver Ring", unit_price: 200.99)
        mood_ring = create(:item, merchant_id: merchant.id, name: "Mood Ring", unit_price: 49.99)
        diamond_necklace = create(:item, merchant_id: merchant.id, name: "Diamond Necklace", unit_price: 2100.99)
        max_price = 400.0

        expect(Item.find_by_max_price(max_price).first).to eq(mood_ring)
        expect(Item.find_by_max_price(max_price).length).to eq(2)
        expect(Item.find_by_max_price(max_price).first.unit_price).to be < max_price
        expect(Item.find_by_max_price(max_price).second.unit_price).to be < max_price
      end
    end
    describe "::find_by_price_range" do
      it "returns an item list where the unit_price is in range between min and max price given and sorted alphabetically" do
        merchant = create(:merchant)
        gold_ring = create(:item, merchant_id: merchant.id, name: "Gold Ring", unit_price: 749.00)
        silver_ring = create(:item, merchant_id: merchant.id, name: "Silver Ring", unit_price: 200.99)
        mood_ring = create(:item, merchant_id: merchant.id, name: "Mood Ring", unit_price: 49.99)
        diamond_necklace = create(:item, merchant_id: merchant.id, name: "Diamond Necklace", unit_price: 2100.99)
        golden_chain = create(:item, merchant_id: merchant.id, name: "Awesome Gold Chain", unit_price: 999.99)
        min_price = 150.00
        max_price = 1000.00
        expect(Item.find_by_price_range(min_price, max_price).first).to eq(golden_chain)
        expect(Item.find_by_price_range(min_price, max_price).length).to eq(3)
        expect(Item.find_by_price_range(min_price, max_price).first.unit_price).to be < max_price
        expect(Item.find_by_price_range(min_price, max_price).first.unit_price).to be > min_price
        expect(Item.find_by_price_range(min_price, max_price).second.unit_price).to be < max_price
        expect(Item.find_by_price_range(min_price, max_price).second.unit_price).to be > min_price
        expect(Item.find_by_price_range(min_price, max_price).third.unit_price).to be < max_price
        expect(Item.find_by_price_range(min_price, max_price).third.unit_price).to be > min_price
      end
    end
  end
end