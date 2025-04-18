# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users

  validates :name, presence: true
  validates :description, presence: true
end
