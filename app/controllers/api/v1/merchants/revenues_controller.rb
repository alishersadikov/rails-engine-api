class Api::V1::Merchants::RevenuesController < ApplicationController

  def index
    render json: Merchant.total_revenue(params[:date])
  end


  def show
    render json: Merchant.find(params[:id]).revenue(params[:date])
  end

  def most
    render json: Merchant.most_revenue(params[:quantity])
  end
end
