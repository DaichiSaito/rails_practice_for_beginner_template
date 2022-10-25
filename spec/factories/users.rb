FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { 'kosuke' }
    sequence(:email) { |n| "kosuke#{n}@example.com" }
    password { 'password' }
  end
end
