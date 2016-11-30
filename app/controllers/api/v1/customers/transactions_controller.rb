class Api::V1::Transactions::InvoicesController < ApplicationController
  def index
    render json: Customer.find(params[:id]).transactions
  end
end
