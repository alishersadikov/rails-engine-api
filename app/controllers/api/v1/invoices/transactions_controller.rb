class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).transactions
  end

  def show
    render json: Transaction.find_by(transaction_params)
  end


  private

  # def transaction_params
  #   params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  # end
end
