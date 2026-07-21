FactoryBot.define do
  factory :transaction do
    association :user
    name { "テスト支出" }
    category { :expense }
    amount { 10000 }
  end

  factory :expense_transaction, class: Transaction do
    association :user
    name { "テスト支出" }
    category { :expense }
    amount { 10000 }
  end

  factory :income_transaction, class: Transaction do
    association :user
    name { "テスト収入" }
    category { :income }
    amount { 10000 }
  end
end