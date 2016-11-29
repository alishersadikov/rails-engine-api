require 'rails_helper'

describe Merchant do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        merchant = Merchant.new

        expect(merchant).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        merchant = Merchant.new(name: "some merchant")

        expect(merchant).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many items" do
      merchant = Merchant.new(name: "some merchant")

      expect(merchant).to respond_to(:items)
    end

    it "has many invoices" do
      merchant = Merchant.new(name: "some merchant")

      expect(merchant).to respond_to(:invoices)
    end

    it "has many customers through invoices" do
      merchant = Merchant.new(name: "some merchant")

      expect(merchant).to respond_to(:customers)
    end
  end
end
