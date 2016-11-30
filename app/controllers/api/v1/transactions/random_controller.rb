class Api::V1::Transactions::RandomController < ApplicationController
  def show
    render json: Transaction.select_random_transaction
  end
end
