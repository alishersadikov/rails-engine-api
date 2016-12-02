require 'rails_helper'

describe Transaction do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a credit card number" do
        transaction = Transaction.new(result: "shipped")

        expect(transaction).to be_invalid
      end

      it "is invalid without a result" do
        transaction = Transaction.new(credit_card_number: "1234")

        expect(transaction).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a credit card number and result" do
        customer = create(:customer)
        merchant = create(:merchant)
        invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
        transaction = invoice.transactions.create(credit_card_number: "1234", result: "shipped", invoice_id: invoice.id)

        expect(transaction).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to an invoice" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "filled")
      transaction = invoice.transactions.create(credit_card_number: "1234", result: "shipped", invoice_id: invoice.id)

      expect(transaction).to respond_to(:invoice)
    end
  end

  describe "scope" do
    let!(:successful_transactions) {
          create_list(:transaction_with_invoice, 2, result: "success")
        }
    let!(:failed_transactions) {
          create_list(:transaction_with_invoice, 3, result: "failed")
        }

    context "successful" do
      it "returns all successful transactions" do
        expect(Transaction.successful.count).to eq(successful_transactions.count)
      end
    end

    context "failed" do
      it "returns all failed transactions" do
        expect(Transaction.failed.count).to eq(failed_transactions.count)
      end
    end
  end
end
