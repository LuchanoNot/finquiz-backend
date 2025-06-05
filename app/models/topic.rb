# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :unit
  has_many :topic_prerequisites, foreign_key: :topic_id, dependent: :destroy
  has_many :prerequisite_topics, through: :topic_prerequisites, source: :prerequisite_topic

  validates :name, :description, :short_description, presence: true
end
