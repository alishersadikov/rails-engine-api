class Api::V1::Merchants::RevenuesController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).revenue
  end
end
