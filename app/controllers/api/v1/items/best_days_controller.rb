class Api::V1::Items::BestDaysController < ApplicationController
  def show
    render json: Item.find(params[:id]).best_day, serializer: BestDaySerializer
  end
end
