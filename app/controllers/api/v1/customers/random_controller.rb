class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: Customer.select_random_customer
  end
end
