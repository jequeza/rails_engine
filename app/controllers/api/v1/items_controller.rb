class Api::V1::ItemsController < ApplicationController
  ITEMS_PER_PAGE = 20
  def index
    if params[:merchant_id]
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
      render json: ItemSerializer.new(items)
    elsif params[:per_page]
      per_page = params[:per_page].to_i
      page = params.fetch(:page, 0).to_i
      items = Item.offset(page * per_page).limit(per_page)
      render json: ItemSerializer.new(items)
    else
      page = params.fetch(:page, 0).to_i
      items = Item.offset(page * ITEMS_PER_PAGE).limit(ITEMS_PER_PAGE)
      render json: ItemSerializer.new(items)
    end
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item), status: 201
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end