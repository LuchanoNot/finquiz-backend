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
    answered_ids  = questionnaires_questions.answered.pluck(:question_id)
    reported_ids  = questions.reported.pluck(:id)

    (answered_ids | reported_ids).size
  end

  def result
    return 0 if questions.empty?

    correct_count = questionnaires_questions.correctly_answered.count

    (correct_count.to_f / questions.not_reported.count * 100).round(1)
  end

  def formatted_created_at
    I18n.l(created_at, format: "%d de %B de %Y", locale: :es)
  end

  def is_completed?
    current_position >= questions.count
  end
end
