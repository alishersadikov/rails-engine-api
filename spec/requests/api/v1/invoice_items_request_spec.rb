require 'rails_helper'

describe 'invoice items endpoints' do
  context 'GET /invoice_items' do
    it 'returns a list of all invoice items' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")

      invoice_item1 = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)
      invoice_item2 = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)

      get '/api/v1/invoice_items'

      invoice_items_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items_parsed.count).to eq(2)
    end
  end

  context 'GET /invoice_items/:id' do
    it 'returns a specific invoice item based on id' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
      invoice_item = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      invoice_item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item_parsed["quantity"]).to eq(invoice_item.quantity)
    end
  end

  context 'GET /api/v1/invoice_items/find?parameters' do
    it 'returns a single invoice item based on id' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
      invoice_item = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)

      get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

      invoice_item_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item_parsed["id"]).to eq(invoice_item.id)
    end

    #also do this for other updated at and created at
  end
#
  context 'GET /api/v1/invoice_items/find_all?paramaters' do
    it 'returns all invoice items based on id' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")

      invoice_item1 = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)
      invoice_item2 = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)

      get "/api/v1/invoice_items/find_all?id=#{invoice_item1.id}"

      invoice_items_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items_parsed.first["id"]).to eq(invoice_item1.id)
    end

    #also do this for other created at and updated at
  end

  context 'GET /api/v1/invoice_items/random' do
    it 'returns a random invoice item' do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item_with_merchant)
      invoice = customer.invoices.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")

      invoice_item1 = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)
      invoice_item2 = invoice.invoice_items.create(item_id: item.id, invoice_id: invoice.id, quantity: 5, unit_price: 10)

      get "/api/v1/invoices/random"

      invoice_item_parsed = JSON.parse(response.body)

      expect(response).to be_success
    #how else to test this?
    end


  end
end
