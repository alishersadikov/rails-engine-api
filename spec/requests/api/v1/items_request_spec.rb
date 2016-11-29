require 'rails_helper'

describe 'items endpoints' do
  context 'GET /items' do
    it 'returns a list of all items' do
      item_list = create_list(:item_with_merchant, 2)

      get '/api/v1/items'

      JSON.parse(response.body)

      expect(response).to be_success
      expect(item_list.count).to eq(2)
    end
  end

  context 'GET /items/:id' do
    it 'returns a specific item based on id' do
      new_item = create(:item_with_merchant)
      new_item2 = create(:item_with_merchant)

      get "/api/v1/items/#{new_item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["name"]).to eq(new_item.name)
    end
  end

  context 'GET /api/v1/items/find?parameters' do
    it 'returns a single item based on id' do
      new_item = create(:item_with_merchant)

      get "/api/v1/items/find?id=#{new_item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["id"]).to eq(new_item.id)
    end

    #also do this for other attributes on items?
  end

  context 'GET /api/v1/items/find_all?paramaters' do
    it 'returns all items based on id' do
      new_item = create(:item_with_merchant)

      get "/api/v1/items/find_all?id=#{new_item.id}"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.first["id"]).to eq(new_item.id)
    end

    #also do this for other attributes on items
  end
#
#   context 'GET /api/v1/invoices/random' do
#     it 'returns a random invoice' do
#       customer = create(:customer)
#       merchant = create(:merchant)
#
#       invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
#       invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"filled")
#
#       get "/api/v1/invoices/random"
#
#       expect(response).to be_success
#     #how else to test this?
#     end
#
#     #also do this for other attributes on invoices?
#   end
#
end
