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
    end
  end
end

