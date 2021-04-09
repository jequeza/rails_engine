class Api::V1::Merchants::FindAllController < ApplicationController
  def index
    found_merchants = Merchant.find_by_name(params[:name])
    render json: MerchantSerializer.new(found_merchants)
  end
end