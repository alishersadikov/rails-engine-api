class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(item_params)
  end

  def index
    render json: Item.where(item_params)
  end

  private

  def item_params
    check_for_unit_price
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

  def check_for_unit_price
    params[:unit_price] = Item.format_unit_price(params) if params[:unit_price]
  end
end
