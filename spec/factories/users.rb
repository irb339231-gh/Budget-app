FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test_#{SecureRandom.uuid}@example.com" }
    password { "ikurahaikaga123" }
    password_confirmation { "ikurahaikaga123" }
  end
end
