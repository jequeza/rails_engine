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
    expect(items[:data].count).to eq(30)
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
  it "returns empty array if no records" do
    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data]).to be_empty
  end
  it "returns one item by the id" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    get "/api/v1/items/#{id}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq(id.to_s)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)
  end
  it "can create a new item with sent params" do
    merchant = create(:merchant)
    item_params = ({
                    name: "value1",
                    description: "value2",
                    unit_price: 100.99,
                    merchant_id: merchant.id
                  })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(merchant.id)
  end
  it "can update an existing item" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    previous_name = Item.last.name
    previous_description = Item.last.description

    item_params = { name: "Hello World", description: "Awesome World!"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.description).to_not eq(previous_description)
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
  end
end