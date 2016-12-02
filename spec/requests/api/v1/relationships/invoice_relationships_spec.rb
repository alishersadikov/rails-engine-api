require 'rails_helper'

describe "invoice relationships" do
  context "GET /api/v1/invoices/:id/transactions" do
    it "returns a list of all transactions associated with one invoice" do
      invoice = create(:invoice_with_transactions)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
      expect(transactions.first["credit_card_number"]).to eq(invoice.transactions.first.credit_card_number)
      expect(transactions.last["result"]).to eq(invoice.transactions.last.result)
    end
  end

  context "GET /api/v1/invoices/:id/invoice_items" do
    it "returns a list of all invoice items associated with one invoice" do
      invoice = create(:invoice_with_customer_and_merchant)
      invoice_item_1 = create(:invoice_item_with_item, invoice_id: invoice.id)
      invoice_item_2 = create(:invoice_item_with_item, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first["quantity"]).to eq(invoice_item_1.quantity)
      expect(invoice_items.last["unit_price"]).to eq("0.10")
    end
  end

  context "GET /api/v1/invoices/:id/items" do
    it "returns a list of all items associated with one invoice" do
      merchant = create(:merchant)
      invoice = create(:invoice_with_customer_and_merchant, merchant_id: merchant.id)
      item_1 = create(:item, merchant_id: merchant.id)
      item_2 = create(:item, merchant_id: merchant.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
      expect(items.first["name"]).to eq(item_1.name)
      expect(items.last["description"]).to eq(item_2.description)
    end
  end

  context "GET /api/v1/invoices/:id/customer" do
    it "returns the associated customer with one invoice" do
      invoice = create(:invoice_with_customer_and_merchant)

      get "/api/v1/invoices/#{invoice.id}/customer"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq(invoice.customer.first_name)
    end
  end

  context "GET /api/v1/invoices/:id/merchant" do
    it "returns the associated merchant with one invoice" do
      invoice = create(:invoice_with_customer_and_merchant)

      get "/api/v1/invoices/#{invoice.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq(invoice.merchant.name)
    end
  end
end
