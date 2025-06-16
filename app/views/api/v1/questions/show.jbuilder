# frozen_string_literal: true

json.extract! @question, :id, :stem, :generating

json.options @question.options.shuffle do |option|
  json.extract! option, :id, :text
end

json.topic do
  json.partial! "api/v1/topics/topic", topic: @question.topic
end
