require 'rails_helper'

describe "invoice_item relationships" do
  context "GET /api/v1/invoice_items/:id/invoice" do
    it "returns the associated invoice with one invoice_item" do
      invoice = create(:invoice_with_customer_and_merchant)
      invoice_item = create(:invoice_item_with_item, invoice_id: invoice.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      parsed_invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_invoice["id"]).to eq(invoice_item.invoice_id)
      expect(parsed_invoice["status"]).to eq(invoice.status)
    end
  end

  context "GET /api/v1/invoices_items/:id/item" do
    it "returns the associated item with one invoice" do
      item = create(:item_with_merchant)
      invoice_item = create(:invoice_item_with_invoice, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      parsed_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_item["id"]).to eq(invoice_item.item_id)
      expect(parsed_item["name"]).to eq(item.name)
    end
  end
end
