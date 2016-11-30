require 'rails_helper'

describe "merchants relationships" do
  context "GET /api/v1/invoices/:id/transactions" do
    it "returns a list of all transactions associated with one invoice" do
      invoice = create(:invoice_with_customer_and_merchant)
      transaction_1 = create(:transaction, invoice_id: invoice.id)
      transaction_2 = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
      expect(transactions.first["credit_card_number"]).to eq(transaction_1.credit_card_number)
      expect(transactions.last["result"]).to eq(transaction_2.result)
    end
  end
end
