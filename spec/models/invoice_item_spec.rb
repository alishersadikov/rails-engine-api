require 'rails_helper'

describe InvoiceItem do
  describe "relationships" do
    let(:invoice_item) { create(:invoice_item_complete) }

    it "is belongs to invoice" do
      expect(invoice_item).to respond_to(:invoice)
    end

    it "is belongs to item" do
      expect(invoice_item).to respond_to(:item)
    end
  end

  describe ".format_unit_price" do
    it "formats incoming price to make the database searchable" do
      params = {"unit_price": "123.45"}
      formatted = InvoiceItem.format_unit_price(params)

      expect(formatted).to eq(12345)
    end

    it "strips extra pair of quotes if needed" do
      params = {"unit_price": "\"123.45\""}
      formatted = InvoiceItem.format_unit_price(params)

      expect(formatted).to eq(12345)
    end
  end
end
