require 'rails_helper'


describe InvoiceItem do

  describe "relationships" do
    it "is belongs to invoice" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
      invoice_item = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)

      expect(invoice_item).to respond_to(:invoice)
    end

    it "is belongs to item" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
      invoice_item = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)

      expect(invoice_item).to respond_to(:item)
    end
  end
end
