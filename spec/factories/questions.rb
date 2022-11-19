FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    solved_check { false }
    user { nil }
  end
end
