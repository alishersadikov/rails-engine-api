require 'rails_helper'

describe 'customers endpoints' do
  context 'GET /customers' do
    it 'returns a list of all customers' do
      # create_list(:customer, 3)

      get '/api/v1/customers'

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end

  # context 'GET /item/:id' do
  #   it 'return specific item' do
  #     item = create(:item, name: "Turkey")
  #
  #     get "/api/v1/customers/#{item.id}"
  #
  #     parsed_item = JSON.parse(response.body)
  #
  #     expect(response).to be_success
  #     expect(item["name"]).to eq("Turkey")
  #   end
  # end

end
