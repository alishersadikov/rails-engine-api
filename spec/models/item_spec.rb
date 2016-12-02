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

  describe ".best_day" do
    it "returns the best day for the item" do
      date = "2016-12-01T17:30:21.051Z"
      item = create(:item_with_merchant)
      invoice_1 = create(:invoice_with_transactions, created_at: date)
      invoice_2 = create(:invoice_with_transactions, created_at: date)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item)
      invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item)

      expect(item.best_day).to eq(date)
    end
  end

  describe ".most_revenue" do
    it "returns the top items ranked by total revenue" do
      item_1, item_2 = create_list(:item_with_merchant, 2)
      invoice_1 = create(:invoice_with_transactions)
      invoice_2 = create(:invoice_with_transactions)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
      invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_2)

      expect(Item.most_revenue.first.name).to eq(item_2.name)
      expect(Item.most_revenue.last.name).to eq(item_1.name)
    end
  end

  describe ".most_items" do
    it "returns the top items ranked by total number sold" do
      item_1, item_2 = create_list(:item_with_merchant, 2)
      invoice_1 = create(:invoice_with_transactions)
      invoice_2 = create(:invoice_with_transactions)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_2)
      invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_2)

      expect(Item.most_items.first.name).to eq(item_2.name)
      expect(Item.most_items.last.name).to eq(item_1.name)
    end
  end
end
