FactoryBot.define do
  factory :order do
    sequence(:kind) { 'V' }
    sequence(:ordered_on) { '2020-05-10' }
    sequence(:retail) { 100000 }
    sequence(:wage) { 1000 }
    sequence(:cloth) { 1000 }
    sequence(:lining) { 1000 }
    sequence(:button) { 1000 }
    sequence(:postage) { 1000 }
    sequence(:other) { 1000 }
    sequence(:note) { 'a' * 40 }
  end
end
