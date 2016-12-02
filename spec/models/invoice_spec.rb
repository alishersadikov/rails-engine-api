require 'rails_helper'
describe Invoice do

  describe "validations" do
    let(:customer) { create(:customer) }
    let(:merchant) { create(:merchant) }

    context "invalid attributes" do
      it "is invalid without a status" do
        invoice = customer.invoices.create(customer_id: 1, merchant_id: 1)
        expect(invoice).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid without correct attributes" do
        invoice = create(:invoice_with_customer_and_merchant)
        expect(invoice).to be_valid
      end
    end
  end

  describe "relationships" do
    let(:invoice) { create(:invoice_with_customer_and_merchant) }

    it "belongs to a customer" do
      expect(invoice).to respond_to(:customer)
    end

    it "belongs to a merchant" do
      expect(invoice).to respond_to(:merchant)
    end

    it "has many transactions" do
      expect(invoice).to respond_to(:transactions)
    end

    it "has many invoice items" do
      expect(invoice).to respond_to(:invoice_items)
    end

    it "has_many items through invoice items" do
      expect(invoice).to respond_to(:items)
    end
  end
end
