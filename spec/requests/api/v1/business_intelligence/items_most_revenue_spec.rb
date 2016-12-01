require 'rails_helper'

describe "item" do
  context "GET /api/v1/items/most_revenue?quantity=x" do
    it "returns the top x items ranked by total revenue" do
      item_1, item_2 = create_list(:item_with_merchant, 2)
      invoice_1 = create(:invoice_with_transactions)
      invoice_2 = create(:invoice_with_transactions)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
      invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_2)

      get "/api/v1/items/most_revenue?quantity=2"

      parsed_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_items.first["name"]).to eq(item_2.name)
    end
  end
end
