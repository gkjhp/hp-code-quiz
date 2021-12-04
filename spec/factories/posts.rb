FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "Thoughful posting ##{n}" }
  end
end
