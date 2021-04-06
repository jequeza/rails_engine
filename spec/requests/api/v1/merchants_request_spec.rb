require 'rails_helper'

RSpec.describe "Merchants API" do
  it "returns a collection of merchants" do
    create_list(:merchant, 20)
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(20)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq("merchant")
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
  it "returns empty array if no records" do
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data]).to be_empty
  end
  it "returns one merchant by the id" do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant[:data].first).to have_key(:id)
    expect(merchant[:data].first[:id]).to eq(id)
    expect(merchant[:data].first[:attributes]).to have_key(:name)
    expect(merchant[:data].first[:attributes][:name]).to be_a(String)
  end
end