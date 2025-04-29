FactoryBot.define do
  factory :questionnaire do
    name { Faker::Lorem.word }
    user { create(:user) }

    after(:create) do |questionnaire|
      create_list(:questionnaires_question, 3, questionnaire: questionnaire)
    end
  end
end
