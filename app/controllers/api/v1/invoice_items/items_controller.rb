class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def show
    render json: InvoiceItem.find(params[:id]).item
  end
end
