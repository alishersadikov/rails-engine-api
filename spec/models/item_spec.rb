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
    it "returns the day with the most sales for the item" do
      date_1 = "2016-12-01T17:30:21.051Z"
      date_2 = "2000-12-01T17:30:21.051Z"
      item = create(:item_with_merchant)
      invoice_1 = create(:invoice_with_transactions, created_at: date_1)
      invoice_2 = create(:invoice_with_transactions, created_at: date_2)
      create(:invoice_item, invoice: invoice_1, item: item)
      create_list(:invoice_item, 2, invoice: invoice_2, item: item)

      expect(item.best_day).to eq(date_2)
    end
  end

  describe ".most_revenue" do
    it "returns the top items ranked by total revenue" do
      item_1, item_2 = create_list(:item_with_merchant, 2)
      invoice_1, invoice_2 = create_list(:invoice_with_transactions, 2)
      create(:invoice_item, invoice: invoice_1, item: item_1)
      create_list(:invoice_item, 2, invoice: invoice_2, item: item_2)

      expect(Item.most_revenue(2).first.id).to eq(item_2.id)
      expect(Item.most_revenue(2).last.id).to eq(item_1.id)
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

      expect(Item.most_items(2).first.id).to eq(item_2.id)
      expect(Item.most_items(2).last.id).to eq(item_1.id)
    end
  end

  describe ".format_unit_price" do
    it "formats incoming price to make the database searchable" do
      params = {"unit_price": "123.45"}
      formatted = Item.format_unit_price(params)

      expect(formatted).to eq(12345)
    end

    it "strips extra pair of quotes if needed" do
      params = {"unit_price": "\"123.45\""}
      formatted = Item.format_unit_price(params)

      expect(formatted).to eq(12345)
    end
  end
end
