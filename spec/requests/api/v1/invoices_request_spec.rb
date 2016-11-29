require 'rails_helper'

describe 'invoices endpoints' do
  context 'GET /invoices' do
    it 'returns a list of all invoices' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
      invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"ordered")

      get '/api/v1/invoices'

      invoices_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices_parsed.count).to eq(2)
    end
  end

  context 'GET /invoices/:id' do
    it 'returns a specific invoice based on id' do
      customer = create(:customer)
      merchant = create(:merchant)
      new_invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")

      get "/api/v1/invoices/#{new_invoice.id}"

      invoice_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_parsed["status"]).to eq(new_invoice.status)
    end
  end

  context 'GET /api/v1/invoices/find?parameters' do
    it 'returns a single invoice based on id' do
      customer = create(:customer)
      merchant = create(:merchant)
      new_invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")

      get "/api/v1/invoices/find?id=#{new_invoice.id}"

      invoice_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_parsed["id"]).to eq(new_invoice.id)
    end

    # it 'returns a single invoice based on created_at' do
    #   customer = create(:customer)
    #   merchant = create(:merchant)
    #   new_invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
    #
    #   get "/api/v1/invoices/find?id=#{new_invoice.created_at}"
    #
    #   invoice_parsed = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(invoice_parsed["created_at"]).to eq(new_invoice.created_at)
    # end
    #
    # it 'returns a single invoice based on updated_at' do
    #   customer = create(:customer)
    #   merchant = create(:merchant)
    #   new_invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
    #
    #   get "/api/v1/invoices/find?id=#{new_invoice.updated_at}"
    #
    #   invoice_parsed = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(invoice_parsed["updated_at"]).to eq(new_invoice.updated_at)
    # end

  end

  context 'GET /api/v1/invoices/find_all?paramaters' do
    it 'returns all invoices based on id' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
      invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"filled")

      get "/api/v1/invoices/find_all?id=#{invoice.id}"

      invoices_parsed = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices_parsed.first["id"]).to eq(invoice.id)
    end

    # it 'returns all invoices based on created_at' do
    #   customer = create(:customer)
    #   merchant = create(:merchant)
    #   invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
    #   invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"filled")
    #
    #   get "/api/v1/invoices/find_all?id=#{invoice.created_at}"
    #
    #   invoices_parsed = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(invoices_parsed.first["created_at"]).to eq(invoice.created_at)
    # end
    #
    # it 'returns all invoices based on updated_at' do
    #   customer = create(:customer)
    #   merchant = create(:merchant)
    #   invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
    #   invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"filled")
    #
    #   get "/api/v1/invoices/find_all?id=#{invoice.updated_at}"
    #
    #   invoices_parsed = JSON.parse(response.body)
    #
    #   expect(response).to be_success
    #   expect(invoices_parsed.first["updated_at"]).to eq(invoice.updated_at)
    # end

    #also do this for other attributes on invoices?
  end

  context 'GET /api/v1/invoices/random' do
    it 'returns a random invoice' do
      customer = create(:customer)
      merchant = create(:merchant)

      invoice = customer.invoices.create(merchant_id: merchant.id, status:"filled")
      invoice2 = customer.invoices.create(merchant_id: merchant.id, status:"filled")

      get "/api/v1/invoices/random"

      expect(response).to be_success
    #how else to test this?
    end

  end
end
