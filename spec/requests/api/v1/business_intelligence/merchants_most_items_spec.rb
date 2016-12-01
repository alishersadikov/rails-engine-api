require 'rails_helper'

describe "merchants" do
  context "GET /api/v1/merchants/most_items?quantity=x" do
    it "returns top x merchants ranked by total number of items sold" do
      merchant_1, merchant_2 = create_list(:merchant, 2)
      invoice_1 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_3 = create(:invoice_with_transactions, merchant_id: merchant_2.id)
      invoice_item_1 = create(:invoice_item_with_item, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item_with_item, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item_with_item, invoice: invoice_3)

      get "/api/v1/merchants/most_items?quantity=2"

      parsed_merchants = JSON.parse(response.body)
      
      expect(response).to be_success
      expect(parsed_merchants.count).to eq(2)
    end
  end
end
