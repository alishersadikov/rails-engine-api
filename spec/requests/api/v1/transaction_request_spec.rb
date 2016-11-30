require 'rails_helper'

describe 'transactions endpoints' do
  context 'GET /transactions' do
    it 'returns a list of all transactions' do
      transaction_1, transaction_2 = create_list(:transaction_with_invoice, 2)

      get '/api/v1/transactions'

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
      expect(transactions.first["first_name"]).to eq(transaction_1.first_name)
      expect(transactions.last["first_name"]).to eq(transaction_2.first_name)
    end
  end

  context 'GET /transactions/:id' do
    xit 'returns a specific transaction based on id' do
      transaction = create(:transaction)

      get "/api/v1/transactions/#{transaction.id}.json"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["first_name"]).to eq(transaction.first_name)
    end
  end

  context 'GET /api/v1/transactions/find?parameters' do
    xit 'returns a single transaction based on id' do
      transaction = create(:transaction)

      get "/api/v1/transactions/find?id=#{transaction.id}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["id"]).to eq(transaction.id)
    end

    xit 'returns a single transaction based on first name' do
      transaction = create(:transaction)

      get "/api/v1/transactions/find?first_name=#{transaction.first_name}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["first_name"]).to eq(transaction.first_name)
    end

    xit 'returns a single transaction based on last name' do
      transaction = create(:transaction)

      get "/api/v1/transactions/find?last_name=#{transaction.last_name}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["last_name"]).to eq(transaction.last_name)
    end
  end

  context 'GET /api/v1/transactions/find_all?parameters' do
    xit 'returns all transactions based on id' do
      transaction_1, transaction_2 = create_list(:transaction, 2)

      get "/api/v1/transactions/find_all?id=#{transaction_2.id}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.first["id"]).to eq(transaction_2.id)
    end

    xit 'returns all transactions based on first name' do
      transaction_1, transaction_2 = create_list(:transaction, 2)

      get "/api/v1/transactions/find_all?first_name=#{transaction_2.first_name}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.first["first_name"]).to eq(transaction_2.first_name)
    end

    xit 'returns all transactions based on last name' do
      transaction_1, transaction_2 = create_list(:transaction, 2)

      get "/api/v1/transactions/find_all?last_name=#{transaction_2.last_name}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.last["last_name"]).to eq(transaction_2.last_name)
    end
  end
end
