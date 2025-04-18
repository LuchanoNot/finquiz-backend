# frozen_string_literal: true

class Unit < ApplicationRecord
  belongs_to :course, optional: false

  validates :name, presence: true
  validates :description, presence: true
  validates :position, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 },
    uniqueness: { scope: :course_id, message: "debe ser único por curso" }
end
