require 'rails_helper'

describe 'customers relationships' do
  context 'GET /api/v1/customers/:id/invoices' do
    it 'returns a list of all invoices associated with one customer' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
      invoice2 = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")

      get "/api/v1/customers/#{customer.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.invoices.count).to eq(2)
      expect(customer.invoices.first["status"]).to eq(invoice.status)
      expect(customer.invoices.last["status"]).to eq(invoice2.status)
    end
  end

  context 'GET /api/v1/customers/:id/transactions' do
    it 'returns a list of all transactions associated with one customer' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
      transaction = invoice.transactions.create(credit_card_number: "123", credit_card_expiration_date: "123", result: "cancelled", invoice_id: invoice.id)
      transaction2 = invoice.transactions.create(credit_card_number: "456", credit_card_expiration_date: "123", result: "cancelled", invoice_id: invoice.id)

      get "/api/v1/customers/#{customer.id}/transactions"

      transactions_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions_parsed.first["id"]).to eq(transaction.id)
      expect(transactions_parsed.last["id"]).to eq(transaction2.id)
    end
  end
end
