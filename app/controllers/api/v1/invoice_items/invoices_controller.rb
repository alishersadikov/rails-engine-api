class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def show
    render json: InvoiceItem.find_by(invoice_id: params[:id]).invoice
  end
end
