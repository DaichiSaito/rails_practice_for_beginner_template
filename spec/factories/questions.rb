FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "question#{n}" }
    body { 'teach me' }
    user

    # 回答付きの質問
    trait :with_answers do
      after(:create) { |question| create_list(:answer, 5, question:) }
    end
  end
end
