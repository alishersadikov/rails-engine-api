require 'rails_helper'

describe 'items endpoints' do
  context 'GET /items' do
    it 'returns a list of all items' do
      item_list = create_list(:item_with_merchant, 2)

      get '/api/v1/items'

      item_list_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_list_parsed.count).to eq(2)
    end
  end

  context 'GET /items/:id' do
    it 'returns a specific item based on id' do
      new_item = create(:item_with_merchant)
      new_item2 = create(:item_with_merchant)

      get "/api/v1/items/#{new_item.id}"

      item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_parsed["name"]).to eq(new_item.name)
    end
  end

  context 'GET /api/v1/items/find?parameters' do
    it 'returns a single item based on id parameter' do
      new_item = create(:item_with_merchant)
      new_item2 = create(:item_with_merchant)

      get "/api/v1/items/find?id=#{new_item.id}"

      item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_parsed["id"]).to eq(new_item.id)
    end

    it 'returns a single item based on name paramater' do
      new_item = create(:item_with_merchant)
      new_item2 = create(:item_with_merchant)

      get "/api/v1/items/find?name=#{new_item.name}"

      item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_parsed["name"]).to eq(new_item.name)
    end

    it 'returns a single item based on description paramater' do
      new_item = create(:item_with_merchant)
      new_item2 = create(:item_with_merchant)

      get "/api/v1/items/find?description=#{new_item.description}"

      item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_parsed["description"]).to eq(new_item.description)
    end

    it 'returns a single item based on merchant id find paramater' do
      new_item = create(:item_with_merchant)
      new_item2 = create(:item_with_merchant)

      get "/api/v1/items/find?merchant_id=#{new_item.merchant_id}"

      item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_parsed["merchant_id"]).to eq(new_item.merchant_id)
    end
  end

  context 'GET /api/v1/items/find_all?paramaters' do
    it 'returns all items based on id' do
      new_item = create(:item_with_merchant)

      get "/api/v1/items/find_all?id=#{new_item.id}"

      item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(item_parsed.first["id"]).to eq(new_item.id)
    end

    it 'returns all items based on name' do
      new_item = create(:item_with_merchant)
      new_item = create(:item_with_merchant)

      get "/api/v1/items/find_all?name=#{new_item.name}"

      items_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(items_parsed.first["name"]).to eq(new_item.name)
      expect(items_parsed.count).to eq(2)
    end
  end

  context 'GET /api/v1/items/random' do
    it 'returns a random item' do
      new_item = create(:item_with_merchant)
      new_item2 = create(:item_with_merchant)

      get "/api/v1/items/random"
      item = JSON.parse(response.body)

      get "/api/v1/items/random"
      item_2 = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
