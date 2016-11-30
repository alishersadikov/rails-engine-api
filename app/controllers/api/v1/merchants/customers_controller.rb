class Api::V1::Merchants::CustomersController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end
end
