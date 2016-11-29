require 'rails_helper'

describe 'customers endpoints' do
  context 'GET /customers' do
    it 'returns a list of all customers' do
      customer_1, customer_2 = create_list(:customer, 2)

      get '/api/v1/customers'

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(2)
      expect(customers.first["first_name"]).to eq(customer_1.first_name)
      expect(customers.last["first_name"]).to eq(customer_2.first_name)
    end
  end

  context 'GET /customers/:id' do
    it 'returns a specific customer based on id' do
      customer = create(:customer)

      get "/api/v1/customers/#{customer.id}.json"

      parsed_customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_customer["first_name"]).to eq(customer.first_name)
    end
  end

  context 'GET /api/v1/customers/find?parameters' do
    it 'returns a single customer based on id' do
      customer = create(:customer)

      get "/api/v1/customers/find?id=#{customer.id}"

      parsed_customer = JSON.parse(response.body)
      byebug
      expect(response).to be_success
      expect(parsed_customer["id"]).to eq(customer.id)
    end

    xit 'returns a single customer based on name' do
      customer = create(:customer)

      get "/api/v1/customers/find?first_name=#{customer.first_name}"

      parsed_customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_customer["first_name"]).to eq(customer.first_name)
    end
  end
end
