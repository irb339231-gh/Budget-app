FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test_#{SecureRandom.uuid}@example.com" }
    password { "ikurahaikaga12" }
    password_confirmation { "ikurahaikaga12" }
  end
end
