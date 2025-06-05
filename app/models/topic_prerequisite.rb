# frozen_string_literal: true

class TopicPrerequisite < ApplicationRecord
  belongs_to :topic
  belongs_to :prerequisite_topic, class_name: "Topic"

  validates :topic_id, uniqueness: { scope: :prerequisite_topic_id, message: "and prerequisite topic combination already exists" }
end
