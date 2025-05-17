# frozen_string_literal: true

class Option < ActiveRecord::Base
  belongs_to :question

  validates :text, :explanation, presence: true

  validate :only_one_correct_answer_per_question

  scope :correct, -> { where(correct: true) }

  private

  def only_one_correct_answer_per_question
    if correct && question.options.correct.where.not(id: id).exists?
      errors.add(:correct, "debe ser único por pregunta")
    end
  end
end
