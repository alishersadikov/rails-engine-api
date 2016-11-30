require 'rails_helper'

describe "invoice_item relationships" do
  context "GET /api/v1/invoice_items/:id/invoice" do
    it "returns the associated invoice with one invoice_item" do
      invoice = create(:invoice_with_customer_and_merchant)
      invoice_item = create(:invoice_item_with_item, invoice_id: invoice.id)

      get "/api/v1/invoice_items/#{invoice.id}/invoice"

      parsed_invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_invoice_item["id"]).to eq(invoice_item.invoice_id)
    end
  end

  context "GET /api/v1/invoices/:id/merchant" do
    xit "returns the associated merchant with one invoice" do
      invoice = create(:invoice_with_customer_and_merchant)

      get "/api/v1/invoices/#{invoice.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq(invoice.merchant.name)
    end
  end
end
