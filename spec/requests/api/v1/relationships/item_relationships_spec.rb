require 'rails_helper'

describe "item relationships" do
  context "GET /api/v1/items/:id/invoice_items" do
    it "returns all associated invoice_items with one item" do
      item = create(:item_with_merchant)
      invoice_item_1, invoice_item_2 = create_list(:invoice_item_with_invoice, 2, item_id: item.id)

      get "/api/v1/items/#{item.id}/invoice_items"

      parsed_invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_invoice_items.first["id"]).to eq(invoice_item_1.id)
      expect(parsed_invoice_items.first["invoice_id"]).to eq(invoice_item_1.invoice_id)
      expect(parsed_invoice_items.last["id"]).to eq(invoice_item_2.id)
      expect(parsed_invoice_items.last["invoice_id"]).to eq(invoice_item_2.invoice_id)
    end
  end

  context "GET /api/v1/items/:id/merchant" do
    it "returns the associated merchant with one item" do
      item = create(:item_with_merchant)

      get "/api/v1/items/#{item.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(item.merchant.id)
      expect(merchant["name"]).to eq(item.merchant.name)
    end
  end
end
