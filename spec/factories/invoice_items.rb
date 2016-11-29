FactoryGirl.define do
  factory :invoice_item do
    factory :invoice_item_with_item do
      merchant {create(:item)}
    end
    factory :invoice_item_with_invoice do
      merchant {create(:invoice)}
    end
    quantity 1
    unit_price 1
  end
end
