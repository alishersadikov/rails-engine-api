require 'rails_helper'

describe "merchant" do
  context "GET /api/v1/merchants/:id/favorite_customer" do
    it "returns the customer with the most successful transactions" do
      customer_1, customer_2 = create_list(:customer, 2)
      merchant = create(:merchant)
      invoice_1 = create(:invoice_with_transactions, customer: customer_1, merchant: merchant)
      invoice_2, invoice_3 = create_list(:invoice_with_transactions, 2, customer: customer_2, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      parsed_customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_customer["id"]).to eq(customer_2.id)
      expect(parsed_customer["first_name"]).to eq(customer_2.first_name)
    end
  end
end
