# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users
  has_many :units, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  def students
    users.student
  end

  def average_completed_questionnaires_per_student
    students_count = students.count
    return 0.0 if students_count.zero?

    completed_total = students.includes(:questionnaires).reduce(0) do |sum, user|
      completed_for_user = user.questionnaires.select(&:is_completed?).size
      sum + completed_for_user
    end

    (completed_total.to_f / students_count).round(1)
  end

  def average_result
    total_count = questionnaires_questions.answered.not_reported.count.to_f
    return 0.0 if total_count.zero?

    correct_count = questionnaires_questions.correctly_answered.count.to_f

    ((correct_count / total_count) * 100).round(1)
  end

  def best_result_topic
    Topic.topics_with_rate(correctly_answered_topics, incorrectly_answered_topics).first
  end

  def worst_result_topic
    Topic.topics_with_rate(incorrectly_answered_topics, correctly_answered_topics).first
  end

  def active_students
    students.select { |student| student.questionnaires.any?(&:is_completed?) }
  end

  def questions_csv_data
    CSV.generate(headers: true) do |csv|
      csv << [ "ID", "Tema", "Unidad", "Enunciado", "Respuesta correcta", "Distractores", "Votos positivos", "Explicación" ]

      all_questions.generated.not_reported.each do |question|
        topic_name = question.topic.name
        unit_name = question.topic.unit.name
        stem = question.stem

        correct_option = question.options.find { |opt| opt.correct }
        explanation = correct_option.explanation
        key = correct_option&.text || ""

        distractors = question.options.reject { |opt| opt.correct }.map(&:text)

        score = question.score

        csv << [
          question.id,
          topic_name,
          unit_name,
          stem,
          key,
          distractors,
          score,
          explanation
        ]
      end
    end
  end

  private

  def all_questions
    Question.joins(topic: { unit: :course })
           .includes(:options, topic: :unit)
           .where(topics: { units: { course_id: id } })
  end

  def questionnaires_questions
    @questionnaires_questions ||= QuestionnairesQuestion.for_course(id)
  end

  def correctly_answered_topics
    @correctly_answered_topics ||= questionnaires_questions
      .correctly_answered
      .joins(question: :topic)
      .group("topics.id")
      .count
  end

  def incorrectly_answered_topics
    @incorrectly_answered_topics ||= questionnaires_questions
      .incorrectly_answered
      .joins(question: :topic)
      .group("topics.id")
      .count
  end
end
