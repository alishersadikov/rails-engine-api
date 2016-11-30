require 'rails_helper'

describe 'merchants relationships' do
  context 'GET /api/v1/merchants/:id/items' do
    it 'returns a list of all items associated with one merchant' do
      merchant = create(:merchant)
      item = merchant.items.create(name: "ItemName", description: "Beauituful item!",  unit_price: 5, merchant_id: merchant.id)
      item2 = merchant.items.create(name: "ItemName2", description: "Beauituful item!",  unit_price: 7, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.items.count).to eq(2)
      expect(merchant.items.first["name"]).to eq(item.name)
    end
  end

  context 'GET /api/v1/merchants/:id/invoices' do
    it 'returns a list of all invoices associated with one merchant' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice1 = customer.invoices.create(merchant_id: merchant.id, status:"filled")
      invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"filled")

      get "/api/v1/merchants/#{merchant.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.invoices.count).to eq(2)
      expect(merchant.invoices.first["status"]).to eq(invoice1.status)
    end
  end
end
