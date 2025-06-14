# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable
  include DeviseTokenAuth::Concerns::User

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
    topics_with_rate(correctly_answered_topics, incorrectly_answered_topics)
  end

  def failure_topics
    topics_with_rate(incorrectly_answered_topics, correctly_answered_topics)
  end

  def stats
    {
      questionnaires_count: questionnaires.count,
      success_topics:,
      failure_topics:
    }
  end


  def topics_with_rate(primary_topics, secondary_topics, threshold = 70)
    answered_rate = {}

    primary_topics.each do |topic_id, primary_count|
      secondary_count = secondary_topics[topic_id]&.to_i || 0
      total_count = primary_count + secondary_count

      if total_count > 0
        rate = (primary_count.to_f / total_count * 100).round(2)
        answered_rate[topic_id] = rate
      end
    end

    filtered_topics = answered_rate.select { |_, rate| rate >= threshold }
    Topic.where(id: filtered_topics.keys)
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

  def answered_questionnaire_questions
    QuestionnairesQuestion.joins(:questionnaire)
                          .where(questionnaires: { user_id: id })
                          .where.not(answered_option_id: nil)
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
end
