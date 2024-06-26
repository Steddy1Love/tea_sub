FactoryBot.define do
  factory :subscription do
    title { "Monthly Green Tea" }
    price { 15.00 }
    status { "active" }
    frequency { "monthly" }
    association :customer
    association :tea
  end
end
