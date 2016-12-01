require 'rails_helper'

describe "merchants" do
  context "GET /api/v1/merchants/most_revenue?quantity=x" do
    it "returns total revenue for all merchant on a specific date" do
      merchant_1, merchant_2 = create_list(:merchant, 2)
      invoice_1 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_3 = create(:invoice_with_transactions, merchant_id: merchant_2.id)
      invoice_item_1 = create(:invoice_item_with_item, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item_with_item, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item_with_item, invoice: invoice_3)

      get "/api/v1/merchants/most_revenue?quantity=2"

      top_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_merchants.count).to eq(2)
      expect(top_merchants.first["id"]).to eq(merchant_1.id)
      expect(top_merchants.last["id"]).to eq(merchant_2.id)
    end
  end
end
