class Api::V1::Items::FindOneController < ApplicationController
  def show
    if params[:name]
      found_item = Item.find_by_name(params[:name])
      render json: ItemSerializer.new(found_item[0])
    elsif params[:min_price]
      found_item = Item.find_by_price(params[:min_price])
      render json: ItemSerializer.new(found_item[0])
    end
  end
end