FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.sentence(word_count: 10) }

    trait :default_course do
      name { "Programación 1" }
      description { "Curso de Programación 1" }
    end
  end
end
