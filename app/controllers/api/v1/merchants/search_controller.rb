class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.find_by(merchant_params)
    return render json: merchant if merchant
    return case_insensitive_search(:one_record)
  end

  def index
    merchants = Merchant.where(merchant_params)
    return render json: merchants if !merchants.empty?
    return case_insensitive_search(:all_records)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

  def case_insensitive_search(type_of_search)
    attribute = merchant_params.keys.first
    t = Merchant.arel_table
    if type_of_search == :one_record
      render json: Merchant.find_by(t[attribute].matches(merchant_params[attribute]))
    else
      render json: Merchant.where(t[attribute].matches(merchant_params[attribute]))
    end
  end
end
