FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test_#{SecureRandom.uuid}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end