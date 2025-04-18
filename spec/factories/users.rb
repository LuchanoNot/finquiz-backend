FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.username }
    email { Faker::Internet.email }
    password { "password" }
    role { :student }
    provider { "email" }
    uid { email }

    trait :teacher do
      role { :teacher }
    end
  end

  trait :without_selected_course do
    selected_course { nil }
  end
end
