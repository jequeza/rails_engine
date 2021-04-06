require 'rails_helper'

RSpec.describe "Merchant Items API" do
  it "can get all the items for given merchant" do
    merchant = create(:merchant)
    5.times{create(:item, merchant_id: merchant.id)}

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end
end