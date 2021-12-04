FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@dev.test" }
    password { 'secret' }
    password_confirmation { password }
  end
end
