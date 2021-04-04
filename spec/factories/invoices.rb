FactoryBot.define do
  factory :invoice do
    customer { nil }
    merchant { nil }
    status { Faker::Number.within(range: 0..2) }
  end
end
