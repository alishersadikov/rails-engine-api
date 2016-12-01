class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).items
  end

  def most
    render json: Merchant.top_merchants(params[:quantity])
  end
end
