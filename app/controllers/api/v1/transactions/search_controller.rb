class Api::V1::Transactions::SearchController < ApplicationController
  def index
    render json: Transaction.where(transaction_params)
  end

  def show
    render json: Transaction.find_by(transaction_params)
  end

  private

  def transaction_params
    params.permit(:id, :credit_card_number, :credit_card_expiration_date,
                  :result, :created_at, :updated_at, :invoice_id)
  end
end
