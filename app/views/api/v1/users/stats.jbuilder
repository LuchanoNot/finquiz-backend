# frozen_string_literal: true

def topic_json(topic)
  {
    id: topic.id,
    name: topic.name,
    shortDescription: topic.short_description
  }
end

json.extract! @stats, :questionnaires_count

json.success_topics do
  json.array! @stats[:success_topics] do |topic|
    json.partial! "api/v1/topics/topic", topic:
  end
end

json.failure_topics do
  json.array! @stats[:failure_topics] do |topic|
    json.partial! "api/v1/topics/topic", topic:
  end
end
