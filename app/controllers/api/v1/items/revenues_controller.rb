class Api::V1::Items::RevenuesController < ApplicationController
  def index
    render json: Item.most_revenue(params[:quantity])
  end
end
