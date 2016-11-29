require 'rails_helper'
#add test for random method?
describe Invoice do

  describe "validations" do

    context "invalid attributes" do
      it "is invalid without a status" do
        customer = create(:customer)
        merchant = create(:merchant)
        invoice = customer.invoices.create(customer_id: 1, merchant_id: 1)
        expect(invoice).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid without correct attributes" do
        customer = create(:customer)
        merchant = create(:merchant)
        invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
        expect(invoice).to be_valid
      end
    end
  end

  describe "relationships" do

    it "belongs to a customer" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
      expect(invoice).to respond_to(:customer)
    end

    it "belongs to a merchant" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
      expect(invoice).to respond_to(:merchant)
    end

    it "has_many transactions" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
      expect(invoice).to respond_to(:transaction)
    end

    it "has_many invoice items" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
      expect(invoice).to respond_to(:invoice_items)
    end

    it "has_many items through invoice items" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
      expect(invoice).to respond_to(:items)
    end
  end
end
