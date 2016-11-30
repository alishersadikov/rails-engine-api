class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    render json: Invoice.find(params[:id]).merchant
  end
end
