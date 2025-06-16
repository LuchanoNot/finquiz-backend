FactoryBot.define do
  factory :question do
    stem { Faker::Lorem.sentence(word_count: 15) }
    score { 0 }
    topic { create(:topic) }

    trait :with_options do
      after(:create) do |question|
        create_list(:option, 2, question: question)
        create(:option, :correct, question: question)
      end
    end
  end
end
