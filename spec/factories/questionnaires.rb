FactoryBot.define do
  factory :questionnaire do
    user { create(:user) }

    after(:create) do |questionnaire|
      3.times do |i|
        create(:questionnaires_question, questionnaire: questionnaire, question: create(:question, :with_options))
      end
    end
  end
end
