require 'rails_helper'

describe 'merchants relationships' do
  context 'GET /api/v1/merchants/:id/items' do
    it 'returns a list of all items associated with one merchant' do
      merchant = create(:merchant)

      item_1, item_2 = create_list(:item, 2, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
      expect(items.first["id"]).to eq(item_1.id)
      expect(items.first["id"]).to eq(item_1.id)
      expect(items.last["id"]).to eq(item_2.id)
    end
  end

  context 'GET /api/v1/merchants/:id/invoices' do
    it 'returns a list of all invoices associated with one merchant' do
      merchant = create(:merchant)
      invoice_1, invoice_2 = create_list(:invoice_with_customer_and_merchant, 2, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      parsed_invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_invoices.count).to eq(2)
      expect(parsed_invoices.first["id"]).to eq(invoice_1.id)
      expect(parsed_invoices.last["id"]).to eq(invoice_2.id)
    end
  end
end
