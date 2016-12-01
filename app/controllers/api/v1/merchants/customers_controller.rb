class Api::V1::Merchants::CustomersController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).customers_with_pending_invoices
  end

  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end
end
