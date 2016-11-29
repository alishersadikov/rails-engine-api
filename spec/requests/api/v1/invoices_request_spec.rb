require 'rails_helper'

describe 'invoices endpoints' do
  context 'GET /invoices' do
    it 'returns a list of all invoices' do
      customer = create(:customer)
      merchant = create(:merchant)

      invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
      invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"ordered")

      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(2)
    end
  end

  context 'GET /invoices/:id' do
    it 'returns a specific invoice based on id' do
      customer = create(:customer)
      merchant = create(:merchant)

      invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")

      get "/api/v1/invoices/#{invoice.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["status"]).to eq("filled")
    end
  end
end
