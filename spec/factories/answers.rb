FactoryBot.define do
  factory :answer do
    body {"ggr"}
    association :question
    association :user
  end
end
