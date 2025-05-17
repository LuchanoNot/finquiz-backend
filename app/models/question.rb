# frozen_string_literal: true

class Question < ActiveRecord::Base
  has_many :options, dependent: :destroy

  has_many :questionnaires_questions, dependent: :destroy
  has_many :questionnaires, through: :questionnaires_questions

  validates :stem, :score, presence: true
end
