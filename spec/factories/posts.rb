FactoryBot.define do
  factory :post do
    content { "MyText" }
    user { nil }
    parent { nil }
    archived_at { "2021-12-04 14:18:14" }
  end
end
