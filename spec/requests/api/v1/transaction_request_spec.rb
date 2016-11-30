require 'rails_helper'

describe 'transactions endpoints' do
  context 'GET /transactions' do
    it 'returns a list of all transactions' do
      transaction_1, transaction_2 = create_list(:transaction_with_invoice, 2)

      get '/api/v1/transactions'

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)
      expect(transactions.first["credit_card_number"]).to eq(transaction_1.credit_card_number)
      expect(transactions.last["credit_card_expiration_date"]).to eq(transaction_2.credit_card_expiration_date)
    end
  end

  context 'GET /transactions/:id' do
    it 'returns a specific transaction based on id' do
      transaction = create(:transaction_with_invoice)

      get "/api/v1/transactions/#{transaction.id}.json"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["credit_card_number"]).to eq(transaction.credit_card_number)
    end
  end

  context 'GET /api/v1/transactions/find?parameters' do
    it 'returns a single transaction based on id' do
      transaction = create(:transaction_with_invoice)

      get "/api/v1/transactions/find?id=#{transaction.id}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["id"]).to eq(transaction.id)
    end

    it 'returns a single transaction based on credit card number' do
      transaction = create(:transaction_with_invoice)

      get "/api/v1/transactions/find?first_name=#{transaction.credit_card_number}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["credit_card_number"]).to eq(transaction.credit_card_number)
    end

    it 'returns a single transaction based on credit card expiration date' do
      transaction = create(:transaction_with_invoice)

      get "/api/v1/transactions/find?last_name=#{transaction.credit_card_expiration_date}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["credit_card_expiration_date"]).to eq(transaction.credit_card_expiration_date)
    end

    it 'returns a single transaction based on result' do
      transaction = create(:transaction_with_invoice)

      get "/api/v1/transactions/find?last_name=#{transaction.result}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["result"]).to eq(transaction.result)
    end

    it 'returns a single transaction based on invoice id' do
      transaction = create(:transaction_with_invoice)

      get "/api/v1/transactions/find?last_name=#{transaction.invoice_id}"

      parsed_transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transaction["invoice_id"]).to eq(transaction.invoice_id)
    end
  end

  context 'GET /api/v1/transactions/find_all?parameters' do
    it 'returns all transactions based on id' do
      transaction_1, transaction_2 = create_list(:transaction_with_invoice, 2)

      get "/api/v1/transactions/find_all?id=#{transaction_2.id}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.first["id"]).to eq(transaction_2.id)
    end

    it 'returns all transactions based on credit card number' do
      transaction_1, transaction_2 = create_list(:transaction_with_invoice, 2)

      get "/api/v1/transactions/find_all?credit_card_number=#{transaction_2.credit_card_number}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.first["credit_card_number"]).to eq(transaction_2.credit_card_number)
    end

    it 'returns all transactions based on credit card expiration date' do
      transaction_1, transaction_2 = create_list(:transaction_with_invoice, 2)

      get "/api/v1/transactions/find_all?credit_card_expiration_date=#{transaction_2.credit_card_expiration_date}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.last["credit_card_expiration_date"]).to eq(transaction_2.credit_card_expiration_date)
    end

    it 'returns all transactions based on result' do
      transaction_1, transaction_2 = create_list(:transaction_with_invoice, 2)

      get "/api/v1/transactions/find_all?result=#{transaction_2.result}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.last["result"]).to eq(transaction_2.result)
   end

    it 'returns all transactions based on invoice id' do
      transaction_1, transaction_2 = create_list(:transaction_with_invoice, 2)

      get "/api/v1/transactions/find_all?invoice_id=#{transaction_2.invoice_id}"

      parsed_transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_transactions.last["invoice_id"]).to eq(transaction_2.invoice_id)
    end
  end
end
