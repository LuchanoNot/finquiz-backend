# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  belongs_to :user

  has_many :questionnaires_questions, dependent: :destroy
  has_many :questions, through: :questionnaires_questions

  has_many :questionnaires_units, dependent: :destroy
  has_many :units, through: :questionnaires_units

  def name
    position = user.questionnaires.order(:created_at).find_index(self) + 1

    "Cuestionario #{position}"
  end

  def current_position
    questionnaires_questions.answered.count
  end

  def result
    return 0 if questions.empty?

    correct_count = questionnaires_questions.correctly_answered.count

    (correct_count.to_f / questions.count * 100).round(2)
  end

  def formatted_created_at
    created_at.strftime("%d de %B de %Y")
  end

  def is_completed?
    current_position >= questions.count
  end
end
