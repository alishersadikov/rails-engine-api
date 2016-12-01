FactoryGirl.define do
  factory :item do
    name "MyString"
    description "MyText"
    unit_price "1.00"
    factory :item_with_merchant do
      merchant {create(:merchant)}
    end
  end
end
