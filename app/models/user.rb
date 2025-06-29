# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable
  include DeviseTokenAuth::Concerns::User

  paginates_per 5

  belongs_to :selected_course, class_name: "Course"
  has_many :course_users, dependent: :destroy
  has_many :courses, through: :course_users, dependent: :destroy
  has_many :questionnaires, dependent: :destroy

  enum :role, [ :student, :teacher ]

  validates :email, :password, :name, :nickname, :role, presence: true, on: :create
  validates :email, uniqueness: true
  validates :role, presence: true
  validate :selected_course_must_belong_to_user, if: :selected_course_id_changed?

  before_validation :assign_default_course, on: :create

  def success_topics
    Topic.topics_with_rate(correctly_answered_topics, incorrectly_answered_topics)
  end

  def failure_topics
    Topic.topics_with_rate(incorrectly_answered_topics, correctly_answered_topics)
  end

  def stats
    {
      questionnaires_count: questionnaires.count,
      success_topics:,
      failure_topics:
    }
  end

  def completed_questionnaires
    questionnaires.select { |questionnaire| questionnaire.is_completed? }
  end

  def correctly_answered_questions_count
    answered_questionnaire_questions.correctly_answered.count
  end

  def incorrectly_answered_questions_count
    answered_questionnaire_questions.incorrectly_answered.count
  end

  def average_result
    total_count = answered_questionnaire_questions.not_reported.count.to_f
    return 0.0 if total_count.zero?

    ((correctly_answered_questions_count.to_f / total_count) * 100).round(1)
  end

  def assign_default_course
    default_course = Course.find_or_create_by!(name: "Programación 1") do |course|
      course.description = "Curso de Programación 1"
    end
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

  private

  def answered_questionnaire_questions
    QuestionnairesQuestion.for_user(id).answered
  end

  def correctly_answered_topics
    @correctly_answered_topics ||= answered_questionnaire_questions.correctly_answered
                .joins(question: :topic)
                .group("topics.id")
                .count
  end

  def incorrectly_answered_topics
    @incorrectly_answered_topics ||= answered_questionnaire_questions.incorrectly_answered
                .joins(question: :topic)
                .group("topics.id")
                .count
  end
end
