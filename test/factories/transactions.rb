FactoryBot.define do
  factory :transaction do
    user { nil }
    name { "MyString" }
    category { 1 }
    amount { 1 }
  end
end
