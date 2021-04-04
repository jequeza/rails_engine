require 'rails_helper'

RSpec.describe "Merchants API" do
  it "returns a collection of merchants" do
    create_list(:merchant, 20)
    get '/api/v1/merchants'
    expect(response).to be_successful
  end
end