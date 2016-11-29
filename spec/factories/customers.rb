FactoryGirl.define do
  factory :customer do
    sequence(:first_name) {|n| "MyFirstName #{n}"}
    last_name "MyLastName"
  end
end
