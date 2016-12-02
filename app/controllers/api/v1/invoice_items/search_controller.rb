class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  private

  def invoice_item_params
    check_for_unit_price
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

  def check_for_unit_price
     params[:unit_price] = InvoiceItem.format_unit_price(params) if  params[:unit_price]
  end
end
