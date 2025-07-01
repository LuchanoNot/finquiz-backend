# frozen_string_literal: true

class Question < ActiveRecord::Base
  belongs_to :topic

  has_many :options, dependent: :destroy
  has_many :questionnaires_questions, dependent: :destroy
  has_many :questionnaires, through: :questionnaires_questions

  validates :stem, :score, presence: true
  validates :topic, presence: true

  scope :reported, -> { where("score < 0") }
  scope :not_reported, -> { where("score >= 0") }
  scope :generated, -> { where(generating: false) }

  def correct_option
    options.correct.first
  end
end
