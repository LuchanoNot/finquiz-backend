# frozen_string_literal: true

json.extract! unit, :id, :name, :description, :position

json.topics do
  json.array! unit.topics.order(:created_at) do |topic|
    json.partial! "api/v1/topics/topic", topic:
  end
end
