class Api::V1::Items::MerchantsController < ApplicationController
  def show
    render json: Item.find(params[:id]).merchant
  end
end
