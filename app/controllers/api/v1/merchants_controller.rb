class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: MerchantsSerializer.format_merchants(merchants)
  end

  def show
    merchant = [Merchant.find(params[:id])]
    render json: MerchantsSerializer.format_merchants(merchant)
  end
end