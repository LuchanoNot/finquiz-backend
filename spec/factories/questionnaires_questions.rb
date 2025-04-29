FactoryBot.define do
  factory :questionnaires_question do
    question { create(:question) }
    questionnaire { create(:questionnaire) }
    position { 0 }
    answered_option { nil }

    trait :with_correct_answered_option do
      answered_option { question.options.correct.first }
    end

    trait :with_incorrect_answered_option do
      answered_option { question.options.where.not(correct: true).first }
    end
  end
end
