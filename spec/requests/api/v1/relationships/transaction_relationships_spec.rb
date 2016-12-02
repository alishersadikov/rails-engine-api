require 'rails_helper'

describe 'transactions relationships' do
  context 'GET /api/v1/transactions/:id/invoice' do
    it 'returns an associated invoice for one transaction' do
      transaction = create(:transaction_with_invoice)
      
      get "/api/v1/transactions/#{transaction.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq(transaction.invoice.status)
    end
  end
end
