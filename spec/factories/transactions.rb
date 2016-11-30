FactoryGirl.define do
  factory :transaction do
    credit_card_number "MyString"
    credit_card_expiration_date "MyString"
    result "success"
    factory :transaction_with_invoice do
      invoice {create(:invoice_with_customer_and_merchant)}
    end
  end
end
