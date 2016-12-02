require 'rails_helper'

describe "merchant" do
  context "GET /api/v1/merchants/:id/revenue?date=x" do
    it "returns total revenue for a single merchant on a specific date" do
      merchant = create(:merchant)
      date = "2016-03-16 11:55:05"
      invoice = create(:invoice_with_transactions, merchant_id: merchant.id, created_at: date)
      create(:invoice_item_with_item, invoice: invoice, created_at: date)

      get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date}"

      parsed_revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_revenue["revenue"]).to eq("20.00")
    end
  end
end
