FactoryBot.define do
  factory :questionnaire do
    user { create(:user) }

    after(:create) do |questionnaire|
      3.times do |i|
        create(:questionnaires_question, questionnaire: questionnaire, question: create(:question, :with_options))
      end
    end

    trait :completed do
      after(:create) do |questionnaire|
        questionnaire.questionnaires_questions.each do |questionnaires_question|
          questionnaires_question.update!(answered_option: questionnaires_question.question.options.correct.first)
        end
      end
    end
  end
end
