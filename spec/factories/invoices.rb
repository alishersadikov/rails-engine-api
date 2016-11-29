FactoryGirl.define do
  factory :invoice do
    customer 1
    merchant 1
    status "MyString"
  end
end
