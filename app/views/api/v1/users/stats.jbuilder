# frozen_string_literal: true

def topic_json(topic)
  {
    id: topic.id,
    name: topic.name,
    shortDescription: topic.short_description
  }
end

json.extract! @stats, :questionnaires_count
json.success_topics @stats[:success_topics].map { |topic| topic_json(topic) }
json.failure_topics @stats[:failure_topics].map { |topic| topic_json(topic) }
