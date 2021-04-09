require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe "class methods" do
    describe "::find_by_name" do
      it "returns a list of records that contain a given name and is sorted alphabetically" do
        merchant1 = create(:merchant, name: "Ingersoll Cutting Tools")
        merchant2 = create(:merchant, name: "Allied Tooling")
        merchant3 = create(:merchant, name: "Pro Tools")
        merchant4 = create(:merchant, name: "Excellent Pools")
        merchant5 = create(:merchant, name: "BBQ n Stuff")
        merchant6 = create(:merchant, name: "All-Truck-Parts")
        name = "ool"

        expect(Merchant.find_by_name(name).length).to eq(4)
        expect(Merchant.find_by_name(name)[0]).to eq(merchant2)
      end
    end
  end
end
