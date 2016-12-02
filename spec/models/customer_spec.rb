require 'rails_helper'

describe Customer do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a first name" do
        customer = Customer.new(last_name: "Casimir")

        expect(customer).to be_invalid
      end

      it "is invalid without a last name" do
        customer = Customer.new(first_name: "Jeff")

        expect(customer).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a with a first_name and last_name" do
        customer = Customer.new(first_name: "Jeff", last_name: "Casimir")

        expect(customer).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many invoices" do
      customer = Customer.new(first_name: "Jeff", last_name: "Casimir")

      expect(customer).to respond_to(:invoices)
    end

    it "has many merchants through invoices" do
      customer = Customer.new(first_name: "Jeff", last_name: "Casimir")

      expect(customer).to respond_to(:merchants)
    end
  end

  describe ".favorite_merchant" do
    it "returns a favorite merchant" do
      customer = create(:customer)
      merchant_1, merchant_2 = create_list(:merchant, 2)
      invoice_1 = create(:invoice_with_transactions, customer: customer, merchant: merchant_1)
      invoice_2 = create(:invoice_with_transactions, customer: customer, merchant: merchant_2)
      invoice_3 = create(:invoice_with_transactions, customer: customer, merchant: merchant_2)

      expect(customer.favorite_merchant).to eq(merchant_2)
    end
  end
end
