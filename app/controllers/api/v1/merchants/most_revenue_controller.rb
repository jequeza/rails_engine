class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    found_merchants = Merchant.find_by_total_revenue(params[:quantity])
    require "pry"; binding.pry
    render json: MerchantRevenueSerializer.new(found_merchants)
  end
end