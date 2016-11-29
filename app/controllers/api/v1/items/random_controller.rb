class Api::V1::Items::RandomController < ApplicationController
  def show
    render json: Item.select_random_item
  end
end
