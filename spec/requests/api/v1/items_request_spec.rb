require 'rails_helper'

RSpec.describe "Items API" do
  it "returns a collections of items" do
    merchant1 = create(:merchant)
    15.times{create(:item, merchant_id: merchant1.id)}
    merchant2 = create(:merchant)
    15.times{create(:item, merchant_id: merchant2.id)}
    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items.count).to eq(30)
    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_a(Integer)
    end
  end
end