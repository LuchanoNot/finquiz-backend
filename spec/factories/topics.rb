FactoryBot.define do
  factory :topic do
    name { Faker::Educator.subject }
    description { Faker::Lorem.sentence(word_count: 20) }
    short_description { Faker::Lorem.sentence(word_count: 5) }
    unit
  end
end
