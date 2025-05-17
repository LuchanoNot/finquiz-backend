# frozen_string_literal: true

class QuestionnairesQuestion < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :question
  belongs_to :answered_option, class_name: "Option", optional: true

  validates :question_id, uniqueness: { scope: :questionnaire_id }
  validates :position, presence: true, uniqueness: { scope: :questionnaire_id }, numericality: { greater_than_or_equal_to: 0 }

  before_create :set_position

  scope :in_order, -> { order(:position) }
  scope :answered, -> { where.not(answered_option: nil) }

  def correct
    answered_option&.correct
  end

  private

  def set_position
    self.position = questionnaire.questionnaires_questions.maximum(:position).to_i + 1
  end
end
