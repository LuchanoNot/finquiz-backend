# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  belongs_to :user

  has_many :questionnaires_questions, dependent: :destroy
  has_many :questions, through: :questionnaires_questions

  has_many :questionnaires_units, dependent: :destroy
  has_many :units, through: :questionnaires_units

  has_many :topics, through: :units

  scope :with_stats_preload, -> {
    includes(
      :questionnaires_questions,
      :questions,
      :units,
      :topics,
      questionnaires_questions: [ :question, :answered_option ],
      questions: [ :topic, :options ]
    )
  }

  def name
    position = user.questionnaires.order(:created_at).find_index(self) + 1

    "Cuestionario #{position}"
  end

  def current_position
    answered_ids  = questionnaires_questions.answered.pluck(:question_id)
    reported_ids  = questions.reported.pluck(:id)

    (answered_ids | reported_ids).size
  end

  def result
    return 0 if questions.empty?

    correct_count = questionnaires_questions.correctly_answered.count

    (correct_count.to_f / questions.not_reported.count * 100).round(1)
  end

  def formatted_created_at
    I18n.l(created_at, format: "%d de %B de %Y", locale: :es)
  end

  def is_completed?
    current_position >= questions.count
  end

  def stats
    topic_stats = questionnaires_questions.not_reported
      .joins(question: :topic)
      .group("topics.id, topics.name")
      .select(
        "topics.id as topic_id",
        "topics.name as topic_name",
        "COUNT(*) as total_questions",
        "COUNT(CASE WHEN options.correct = true THEN 1 END) as correct_answers"
      )
      .joins("LEFT JOIN options ON questionnaires_questions.answered_option_id = options.id")

    stats_by_topic = topic_stats.map do |stat|
      topic_correct_percentage = stat.total_questions > 0 ? (stat.correct_answers.to_f / stat.total_questions * 100).round(1) : 0

      {
        topic_name: stat.topic_name,
        topic_id: stat.topic_id,
        total: topic_correct_percentage
      }
    end

    {
      total: result,
      stats_by_topic: stats_by_topic
    }
  end
end
