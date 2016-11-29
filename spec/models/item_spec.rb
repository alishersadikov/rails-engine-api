require 'rails_helper'

describe Item do

  describe "validations" do
    context "invalid attributes" do

      it "is invalid without a name" do
        merchant = create(:merchant)
        item = merchant.items.create(description: "Item description!", unit_price: 5, merchant_id: merchant.id)

        expect(item).to be_invalid
      end

      it "is invalid without a description" do
        merchant = create(:merchant)
        item = merchant.items.create(name: "ItemName", unit_price: 5, merchant_id: merchant.id)

        expect(item).to be_invalid
      end

      it "is invalid without a unit price" do
        merchant = create(:merchant)
        item = merchant.items.create(name: "ItemName", description: "Item description!", merchant_id: merchant.id)

        expect(item).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid without correct attributes" do
        merchant = create(:merchant)
        item = merchant.items.create(name: "ItemName", description: "Item description!", unit_price: 5, merchant_id: merchant.id)

        expect(item).to be_valid
      end
    end
  end

  describe "relationships" do

    it "belongs to a merchant" do
      merchant = create(:merchant)
      item = merchant.items.create(name: "ItemName", description: "Item description!", unit_price: 5, merchant_id: merchant.id)

      expect(item).to respond_to(:merchant)
    end

    it "has many invoice items" do
      merchant = create(:merchant)
      item = merchant.items.create(name: "ItemName", description: "Item description!", unit_price: 5, merchant_id: merchant.id)

      expect(item).to respond_to(:invoice_items)
    end

    it "has many invoices through invoice items" do
      merchant = create(:merchant)
      item = merchant.items.create(name: "ItemName", description: "Item description!", unit_price: 5, merchant_id: merchant.id)

      expect(item).to respond_to(:invoices)
    end
  end
end
