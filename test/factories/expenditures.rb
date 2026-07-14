FactoryBot.define do
  factory :expenditure do
    association :user
    name { "テストデータ" }
    category { :income }
    amount { 100000 }
  end

  factory :income, class: Expenditure do
    association :user
    name { "貯蓄" }
    category { :income }
    amount { 1000000 }
  end

  factory :future_expense, class: Expenditure do
    association :user
    name { "引っ越し費用" }
    category { :future_expense }
    amount { 300000 }
  end

  factory :fixed_cost, class: Expenditure do
    association :user
    name { "社会保険" }
    category { :fixed_cost }
    amount { 30000 }
  end
end
