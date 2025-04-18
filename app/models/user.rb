# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable
  include DeviseTokenAuth::Concerns::User

  belongs_to :selected_course, class_name: "Course"
  has_many :course_users, dependent: :destroy
  has_many :courses, through: :course_users, dependent: :destroy

  enum :role, [ :student, :teacher ]

  validates :email, :password, :name, :nickname, :role, presence: true, on: :create
  validates :email, uniqueness: true
  validates :role, presence: true
  validate :selected_course_must_belong_to_user, if: :selected_course_id_changed?

  before_validation :assign_default_course, on: :create

  private

  def assign_default_course
    default_course = Course.find_or_create_by!(name: "Programación 1", description: "Curso de Programación 1")
    courses << default_course unless self.courses.loaded? && self.courses.include?(default_course)
    self.selected_course = default_course
  end

  def selected_course_must_belong_to_user
    return unless selected_course.present?
    current_course_ids = courses.map(&:id)
    unless current_course_ids.include?(selected_course.id)
      errors.add(:selected_course, "must be one of the user's courses")
    end
  end
end
