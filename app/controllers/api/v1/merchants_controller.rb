class Api::V1::MerchantsController < ApplicationController
  MERCHANTS_PER_PAGE = 20
  def index
    if params[:per_page]
      per_page = params[:per_page].to_i
      page = params.fetch(:page, 0).to_i
      merchants = Merchant.offset(page * per_page).limit(per_page)
      render json: MerchantSerializer.new(merchants)
    else
      page = params.fetch(:page, 0).to_i
      merchants = Merchant.offset(page * MERCHANTS_PER_PAGE).limit(MERCHANTS_PER_PAGE)
      render json: MerchantSerializer.new(merchants)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end
end