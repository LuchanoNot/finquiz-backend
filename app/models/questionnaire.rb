# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  belongs_to :user

  has_many :questionnaires_questions, dependent: :destroy
  has_many :questions, through: :questionnaires_questions

  has_many :questionnaires_units, dependent: :destroy
  has_many :units, through: :questionnaires_units

  validates :name, presence: true
end
