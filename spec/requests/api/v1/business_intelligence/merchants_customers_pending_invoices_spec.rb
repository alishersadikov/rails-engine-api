require 'rails_helper'

describe 'merchants endpoint showing customers with pending invoices' do
  context 'GET /api/v1/merchants/:id/customers_with_pending_invoices' do
    it 'returns a list of all customers with pending invoice for one merchant' do
      customer_1, customer_2 = create_list(:customer, 2)
      merchant = create(:merchant)
      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
      failed_transaction_1 = create(:transaction, result: "failed", invoice: invoice_1)
      successful_transaction = create(:transaction, result: "success", invoice: invoice_1)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
      failed_transaction_2 = create(:transaction, result: "failed", invoice: invoice_2)

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      parsed_customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_customers.first["id"]).to eq(customer_2.id)
      expect(parsed_customers.first["first_name"]).to eq(customer_2.first_name)
      expect(parsed_customers.first["id"]).to_not eq(customer_1.id)
    end
  end
end
