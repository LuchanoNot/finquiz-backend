# frozen_string_literal: true

class GenerateQuestionsJob < ApplicationJob
  queue_as :default

  def perform(questionnaire_id)
    questionnaire = Questionnaire.find(questionnaire_id)

    questionnaire.questions.each do |question|
      next unless question.reload.generating
      generated_data = nil
      begin
        generated_data = MCQGenerationService.new.generate_complete_question(topic_id: question.topic_id)
      rescue StandardError => e
        Rails.logger.error("Error generating question: #{e.message}")
        next
      end

      unless valid_format(generated_data)
        Rails.logger.error("Invalid format for generated data: #{generated_data}")
        question.destroy
        next
      end

      persist_generated_data(question, generated_data)
    end
  end

  private

  def persist_generated_data(question, generated_data)
    ActiveRecord::Base.transaction do
      question.update!(stem: generated_data[:question], generating: false)

      question.options.create!(
        text: generated_data[:correct_answer],
        correct: true,
        explanation: generated_data[:explanation]
      )

      generated_data[:distractors].each do |distractor|
        question.options.create!(
          text: distractor["text"],
          correct: false,
          explanation: distractor["evaluation"] + "\n\n***¿Cuál es el razonamiento correcto?***\n\n" + generated_data[:explanation]
        )
      end
    end
  end

  def valid_format(generated_data)
    generated_data[:distractors].present? && generated_data.is_a?(Hash) &&
      generated_data[:question].is_a?(String) &&
      generated_data[:correct_answer].is_a?(String) &&
      generated_data[:explanation].is_a?(String) &&
      generated_data[:distractors].is_a?(Array) &&
      generated_data[:distractors].all? { |d| d.is_a?(Hash) && d["text"].is_a?(String) } &&
      generated_data[:distractors].all? { |d| d.is_a?(Hash) && d["evaluation"].is_a?(String) }
  end
end
