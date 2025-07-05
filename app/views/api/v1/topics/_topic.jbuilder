# frozen_string_literal: true

json.extract! topic, :id, :name, :description, :short_description, :notes

json.prerequisite_topic_ids topic.prerequisite_topic_ids
