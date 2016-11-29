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
end
