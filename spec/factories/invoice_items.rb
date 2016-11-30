FactoryGirl.define do
  factory :invoice_item do
    factory :invoice_item_with_item do
      item {create(:item_with_merchant)}
    end
    factory :invoice_item_with_invoice do
      invoice {create(:invoice)}
    end
    quantity 1
    unit_price 1
  end
end
