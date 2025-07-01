FactoryBot.define do
  factory :questionnaire do
    user { create(:user) }

    transient do
      skip_questions { false }
    end

    after(:create) do |questionnaire, evaluator|
      next if evaluator.skip_questions

      # Create a course, unit, and topic structure if not provided
      course = create(:course, :with_units)
      unit = course.units.first
      topic = create(:topic, unit: unit)

      3.times do |i|
        create(:questionnaires_question, questionnaire: questionnaire,
               question: create(:question, :with_options, topic: topic))
      end
    end

    trait :completed do
      after(:create) do |questionnaire|
        questionnaire.questionnaires_questions.each do |questionnaires_question|
          questionnaires_question.update!(answered_option: questionnaires_question.question.options.correct.first)
        end
      end
    end

    trait :without_questions do
      skip_questions { true }
    end
  end
end
