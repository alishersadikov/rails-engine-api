require 'rails_helper'

describe "customer" do
  context "GET /api/v1/customers/:id/favorite_merchant" do
    it "returns the merchant the customer has conducted the most successful transactions with" do
      customer = create(:customer)
      merchant_1, merchant_2 = create_list(:merchant, 2)
      invoice_1 = create(:invoice_with_transactions, customer: customer, merchant: merchant_1)
      invoice_2 = create(:invoice_with_transactions, customer: customer, merchant: merchant_2)
      invoice_3 = create(:invoice_with_transactions, customer: customer, merchant: merchant_2)

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      parsed_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_merchant["name"]).to eq(merchant_2.name)
    end
  end
end
