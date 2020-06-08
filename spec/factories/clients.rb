FactoryBot.define do
  factory :client do
    sequence(:name) { "山田　太郎" }
    sequence(:kana) { "ヤマダ　タロウ" }
  end
end
