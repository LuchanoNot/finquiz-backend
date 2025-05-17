# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  belongs_to :user

  has_many :questionnaires_questions, dependent: :destroy
  has_many :questions, through: :questionnaires_questions

  has_many :questionnaires_units, dependent: :destroy
  has_many :units, through: :questionnaires_units

  def current_position
    questionnaires_questions.answered.count
  end
end
