FactoryBot.define do
  factory :learning_aid do
    name { Faker::Lorem.word }
    url { Faker::Internet.url }
    topic
  end
end
