FactoryBot.define do
  factory :customer do
    first_name { "John" }
    last_name { "Doe" }
    email { "test@email.com" }
    address { "420 Matcha Ave" }
  end
end