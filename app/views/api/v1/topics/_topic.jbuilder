# frozen_string_literal: true

json.extract! topic, :id, :name, :description, :short_description, :notes, :question_types

json.prerequisite_topic_ids topic.prerequisite_topic_ids

json.learning_aids do
  json.array! topic.learning_aids, :id, :name, :url
end
