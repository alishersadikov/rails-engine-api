require 'rails_helper'

describe 'merchants endpoints' do
  context 'GET /merchants' do
    it 'returns a list of all merchants' do
      merchant_1, merchant_2 = create_list(:merchant, 2)

      get '/api/v1/merchants.json'

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(2)
      expect(merchants.first["name"]).to eq(merchant_1.name)
      expect(merchants.last["name"]).to eq(merchant_2.name)
    end
  end

  context 'GET /merchants/:id' do
    it 'returns a specific merchant based on id' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}.json"

      parsed_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_merchant["name"]).to eq(merchant.name)
    end
  end

  context 'GET /api/v1/merchants/find?parameters' do
    it 'returns a single merchant based on id' do
      merchant = create(:merchant)

      get "/api/v1/merchants/find?id=#{merchant.id}"

      parsed_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_merchant["id"]).to eq(merchant.id)
    end

    it 'returns a single merchant based on name' do
      merchant = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant.name}"

      parsed_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_merchant["name"]).to eq(merchant.name)
    end

    # it 'returns a single merchant based on created at timestamp' do
    #   time = Time.now
    #   merchant = Merchant.create(name: "Merchant", created_at: time)
    #
    #   get "/api/v1/merchants/find?created_at=#{time}"
    #
    #   parsed_merchant = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(parsed_merchant["created_at"]).to eq(time)
    # end
  end

  context 'GET /api/v1/merchants/find_all?parameters' do
    it 'returns all merchants based on id' do
      merchant_1, merchant_2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find_all?id=#{merchant_2.id}"

      parsed_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_merchants.first["id"]).to eq(merchant_2.id)
    end

    it 'returns all merchants based on name' do
      merchant_1, merchant_2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find_all?name=#{merchant_2.name}"

      parsed_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_merchants.first["name"]).to eq(merchant_2.name)
    end
  end
end
