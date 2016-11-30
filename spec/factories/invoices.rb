FactoryGirl.define do
  factory :invoice do
    customer nil
    merchant nil
    status "MyString"

    factory :invoice_with_customer_and_merchant do
      customer {create(:customer)}
      merchant {create(:merchant)}
    end
  end
end
