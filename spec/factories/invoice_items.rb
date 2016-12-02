FactoryGirl.define do
  factory :invoice_item do
    factory :invoice_item_with_item do
      item {create(:item_with_merchant)}
    end

    factory :invoice_item_with_invoice do
      invoice {create(:invoice_with_customer_and_merchant)}
    end

    factory :invoice_item_complete do
      item {create(:item_with_merchant)}
      invoice {create(:invoice_with_customer_and_merchant)}
    end

    quantity 100
    unit_price "10.75"
  end
end
