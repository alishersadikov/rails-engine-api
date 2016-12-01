require 'rails_helper'

describe "item" do
  context "GET /api/v1/items/:id/best_day" do
    it "returns the day with the most sales for an item" do
      date = "2016-12-01T17:30:21.051Z"
      item = create(:item_with_merchant)
      invoice_1 = create(:invoice_with_transactions, created_at: date)
      invoice_2 = create(:invoice_with_transactions, created_at: date)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item)
      invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item)

      get "/api/v1/items/#{item.id}/best_day"

      parsed_date = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_date["date"]).to eq(date)
    end
  end
end
