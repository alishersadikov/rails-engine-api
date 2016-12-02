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
    let(:merchant) { create(:merchant)}

    it "has many items" do
      expect(merchant).to respond_to(:items)
    end

    it "has many invoices" do
      expect(merchant).to respond_to(:invoices)
    end

    it "has many customers through invoices" do
      expect(merchant).to respond_to(:customers)
    end

    it "has many invoice items through invoices" do
      expect(merchant).to respond_to(:invoice_items)
    end

    it "has many transactions through invoices" do
      expect(merchant).to respond_to(:transactions)
    end
  end

  describe ".revenue" do
    let!(:merchant) { create(:merchant) }
    let!(:invoice) { create(:invoice_with_transactions, merchant_id: merchant.id) }
    let!(:invoice_item) { create(:invoice_item_with_item, invoice: invoice) }

    it "returns the total revenue for merchant across all transactions" do
      expect(merchant.revenue).to eq(2000)
    end

    it "returns the total revenue for merchant across transactions for a specific date" do
      date = "2016-03-16 11:55:05"
      invoice_2 = create(:invoice_with_transactions, merchant_id: merchant.id, created_at: date)
      invoice_items = create_list(:invoice_item_with_item, 2, invoice: invoice_2, created_at: date)

      expect(merchant.revenue(date)).to eq(4000)
    end
  end

  describe ".total_revenue" do
    it "returns the total revenue across merchants for a specific date" do
      merchant = create(:merchant)
      date = "2016-03-16 11:55:05"
      invoice_1 = create(:invoice_with_transactions, merchant_id: merchant.id, created_at: date)
      invoice_item_1 = create(:invoice_item_with_item, invoice: invoice_1, created_at: date)

      expect(Merchant.total_revenue(date)).to eq(2000)
    end
  end

  describe ".favorite_customer" do
    it "returns the customer who has conducted most business for a merchant" do
      customer_1, customer_2 = create_list(:customer, 2)
      merchant = create(:merchant)
      invoice_1 = create(:invoice_with_transactions, customer: customer_1, merchant: merchant)
      invoice_2 = create(:invoice_with_transactions, customer: customer_2, merchant: merchant)
      invoice_3 = create(:invoice_with_transactions, customer: customer_2, merchant: merchant)

      expect(merchant.favorite_customer).to eq(customer_2)
    end
  end

  describe ".top_merchants" do
    it "returns the top merchants ranked by total number of items sold" do
      merchant_1, merchant_2 = create_list(:merchant, 2)
      invoice_1 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_3 = create(:invoice_with_transactions, merchant_id: merchant_2.id)
      invoice_item_1 = create(:invoice_item_with_item, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item_with_item, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item_with_item, invoice: invoice_3)

      expect(Merchant.top_merchants(2).first).to eq(merchant_1)
      expect(Merchant.top_merchants(2).last).to eq(merchant_2)
    end
  end

  describe ".most_revenue" do
    it "returns the top merchants ranked by total revenue" do
      merchant_1, merchant_2 = create_list(:merchant, 2)
      invoice_1 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice_with_transactions, merchant_id: merchant_1.id)
      invoice_3 = create(:invoice_with_transactions, merchant_id: merchant_2.id)
      invoice_item_1 = create(:invoice_item_with_item, invoice: invoice_1)
      invoice_item_2 = create(:invoice_item_with_item, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item_with_item, invoice: invoice_3)

      expect(Merchant.most_revenue(2).first).to eq(merchant_1)
      expect(Merchant.most_revenue(2).last).to eq(merchant_2)
    end
  end

  describe ".customers_with_pending_invoices" do
    it "returns a list of customers with pending invoices" do
      customer_1, customer_2 = create_list(:customer, 2)
      merchant = create(:merchant)
      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
      failed_transaction_1 = create(:transaction, result: "failed", invoice: invoice_1)
      successful_transaction = create(:transaction, result: "success", invoice: invoice_1)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
      failed_transaction_2 = create(:transaction, result: "failed", invoice: invoice_2)

      expect(merchant.customers_with_pending_invoices.first).to eq(customer_2)
      expect(merchant.customers_with_pending_invoices.last).to_not eq(customer_1)
    end
  end
end
