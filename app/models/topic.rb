# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :unit
  has_many :questions, dependent: :destroy
  has_many :topic_prerequisites, foreign_key: :topic_id, dependent: :destroy
  has_many :prerequisite_topics, through: :topic_prerequisites, source: :prerequisite_topic

  validates :name, :description, :short_description, presence: true

  def prompt
    <<~QUESTION_TOPIC
      La pregunta generada debe estar relacionada con el tema **"#{name}"**, que abarca:
      #{description}
      Ten en cuenta las siguientes notas:
      #{notes}
    QUESTION_TOPIC
  end

  def self.topics_with_rate(primary_topics, secondary_topics, threshold = 70)
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
end
