# frozen_string_literal: true

class LearningAid < ApplicationRecord
  belongs_to :topic

  validates :name, :url, presence: true
  validates :url, format: { with: URI.regexp }
end
