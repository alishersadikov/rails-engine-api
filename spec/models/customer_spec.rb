require 'rails_helper'

describe Customer do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a first name" do
        customer = Customer.new(last_name: "Casimir")

        expect(customer).to be_invalid
      end

      it "is invalid without a last_name" do
        customer = Customer.new(first_name: "Jeff")

        expect(customer).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a credit card number and result" do
        customer = create(:customer)
        merchant = create(:merchant)
        invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
        customer = invoice.customers.create(credit_card_number: "1234", result: "shipped", invoice_id: invoice.id)

        expect(customer).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to an invoice" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
      customer = invoice.customers.create(credit_card_number: "1234", result: "shipped", invoice_id: invoice.id)

      expect(customer).to respond_to(:invoice)
    end
  end
end
