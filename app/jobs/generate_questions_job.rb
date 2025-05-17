  class GenerateQuestionsJob < ApplicationJob
  queue_as :default

  def perform(questionnaire_id)
    questionnaire = Questionnaire.find(questionnaire_id)

    # Agregarle logging!!!!
    # Si falla una, seguir con la siguiente y dejar la anterior como no generada.
    questionnaire.questions.each do |question|
      next unless question.reload.generating # Esto es todo teorico, pero y si el reload arregla el tema de la validacion de options?

      generated_data = MCQGenerationService.new.generate_complete_question

      puts generated_data

      # ?: Si dejamos la validacion en options, esto falla nada q ver
      ActiveRecord::Base.transaction do
        question.update!(stem: generated_data[:question], generating: false)

        question.options.create!(
          text: generated_data[:correct_answer],
          correct: true,
          explanation: generated_data[:explanation]
        )

        generated_data[:distractors].each do |distractor|
          question.options.create!(text: distractor["text"], correct: false, explanation: distractor["evaluation"])
        end
      end
    end
  end
  end
