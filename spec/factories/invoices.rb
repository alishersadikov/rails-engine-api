FactoryGirl.define do
  factory :invoice do
    customer nil
    merchant nil
    status "MyString"

    factory :invoice_with_customer_and_merchant do
      customer {create(:customer)}
      merchant {create(:merchant)}

      factory :invoice_with_transactions do
        transient do
          transaction_count 2
        end

        after(:create) do |invoice, evaluator|
          create_list(:transaction, evaluator.transaction_count,
                                                invoice: invoice)
        end
      end
    end

  end
end
