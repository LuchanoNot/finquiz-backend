FactoryBot.define do
  factory :option do
    text { Faker::Quotes::Shakespeare.hamlet_quote }
    explanation { Faker::Lorem.sentence(word_count: 10) }
    correct { false }
    association :question

    trait :correct do
      correct { true }
    end
  end
end
