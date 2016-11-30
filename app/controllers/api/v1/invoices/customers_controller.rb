class Api::V1::Invoices::CustomersController < ApplicationController
  def show
    render json: Invoice.find(params[:id]).customer
  end
end
