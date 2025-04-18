FactoryBot.define do
  factory :unit do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.sentence(word_count: 10) }
    course
    position { Unit.where(course: course).maximum(:position).to_i + 1 }
  end
end
