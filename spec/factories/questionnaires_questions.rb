FactoryBot.define do
  factory :questionnaires_question do
    position { 0 }
    answered_option { nil }
    association :question
    association :questionnaire

    trait :with_correct_answered_option do
      question { create(:question, :with_options) }
      answered_option { question.options.correct.first }
    end

    trait :with_incorrect_answered_option do
      question { create(:question, :with_options) }
      answered_option { question.options.where.not(correct: true).first }
    end
  end
end
