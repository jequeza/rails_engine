require 'rails_helper'

RSpec.describe "Item Merchant API" do
  it "can get the merchant for a given item" do
    merchant1 = create(:merchant)
    item = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(merchant1.id.to_s)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end