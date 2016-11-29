require 'rails_helper'

describe 'merchants endpoint showing customers with pending invoices' do
  context 'GET /api/v1/merchants/:id/customers_with_pending_invoices' do
    it 'returns a list of all customers with pending invoice for one merchant' do
      customer = create(:customer)
      merchant = create(:merchant)
      
    end
  end
end
