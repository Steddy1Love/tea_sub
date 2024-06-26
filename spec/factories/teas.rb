FactoryBot.define do
  factory :tea do
    title { "Green Tea" }
    description { "Arizona's green tea leaves" }
    temperature { "80 C" }
    brew_time { "3 minutes" }
  end
end