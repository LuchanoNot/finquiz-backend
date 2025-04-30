# frozen_string_literal: true

class Question < ActiveRecord::Base
  has_many :options, dependent: :destroy

  validates :stem, :score, presence: true
  validate :options_validation

  private

  def options_validation
    correct_options_count = options.count(&:correct?)

    if correct_options_count > 1
      errors.add(:options, "shouldn't have more than one correct option")
    end
  end
end
