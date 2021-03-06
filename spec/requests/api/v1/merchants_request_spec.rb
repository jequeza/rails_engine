require 'rails_helper'

RSpec.describe "Merchants API" do
  it "returns a collection of merchants" do
    create_list(:merchant, 40)
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(20)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq("merchant")
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
  it "returns collection with the given amount of merchants" do
    create_list(:merchant, 100)
    get '/api/v1/merchants?per_page=55'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(55)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
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
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(id.to_s)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
  it "returns a list of merchants matching a given name" do
    merchant1 = create(:merchant, name: "Ingersoll Cutting Tools")
    merchant2 = create(:merchant, name: "Allied Tooling")
    merchant3 = create(:merchant, name: "Pro Tools")
    merchant4 = create(:merchant, name: "Excellent Pools")
    merchant5 = create(:merchant, name: "BBQ n Stuff")
    merchant6 = create(:merchant, name: "All-Truck-Parts")
    get "/api/v1/merchants/find_all?name=ool"

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].length).to eq(4)
  end
end