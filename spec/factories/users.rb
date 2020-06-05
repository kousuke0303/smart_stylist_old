FactoryBot.define do
  factory :user do
    sequence(:name) { "test" }
    sequence(:email) { "test@email.com" }
    sequence(:question) { "好きな食べ物は？" }
    sequence(:answer) { "リンゴ" }
    sequence(:customer_id) { "test_customer" }
    sequence(:card_id) { "test_card" }
    sequence(:subscription_id) { "test_subscription" }
    sequence(:pay_status) { true }
    sequence(:password) { "password" }
    sequence(:password_confirmation) { "password" }
  end
end
