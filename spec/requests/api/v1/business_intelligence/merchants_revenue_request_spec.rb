require 'rails_helper'

describe "merchant" do
  context "GET /api/v1/merchants/:id/revenue" do
    it "returns total revenue for a single merchant across all transactions" do
      # a merchant has many invoices
      # an invoice has many items through invoice_items
      # an item has quantity and unit price

      merchant = create(:merchant)
      invoice_1 = create(:invoice_with_transactions, merchant_id: merchant.id)
      invoice_item_1 = create(:invoice_item_with_item, invoice: invoice_1)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      revenue = JSON.parse(response.body)

      expect(response).to be_success
      expect(revenue["revenue"]).to eq(1234)
    end
  end
end
