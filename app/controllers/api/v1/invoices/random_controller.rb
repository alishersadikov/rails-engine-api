class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: Invoice.select_random_invoice
  end
end
