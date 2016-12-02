require 'rails_helper'

describe 'customers relationships' do
  context 'GET /api/v1/customers/:id/invoices' do
    it 'returns a list of all invoices associated with one customer' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice_1, invoice_2 = create_list(:invoice, 2, customer: customer, merchant: merchant)

      get "/api/v1/customers/#{customer.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
      expect(invoices.first["id"]).to eq(invoice_1.id)
      expect(invoices.last["id"]).to eq(invoice_2.id)
    end
  end

  context 'GET /api/v1/customers/:id/transactions' do
    it 'returns a list of all transactions associated with one customer' do
      customer = create(:customer)
      invoice = create(:invoice_with_transactions, customer: customer)

      get "/api/v1/customers/#{customer.id}/transactions"

      transactions_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions_parsed.first["id"]).to eq(invoice.transactions.first.id)
      expect(transactions_parsed.last["id"]).to eq(invoice.transactions.last.id)
    end
  end
end
