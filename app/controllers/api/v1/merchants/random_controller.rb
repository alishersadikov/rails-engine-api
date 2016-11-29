class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render json: Merchant.select_random_merchant
  end
end
