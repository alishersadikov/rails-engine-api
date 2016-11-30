class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    render json: InvoiceItem.select_random_invoice_item
  end
end
