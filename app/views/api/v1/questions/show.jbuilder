# frozen_string_literal: true

json.extract! @question, :id, :stem, :generating, :score

# deterministic shuffle: same order for the same question across requests
json.options @question.options.shuffle(random: Random.new(@question.id)) do |option|
  json.extract! option, :id, :text
end

json.topic do
  json.partial! "api/v1/topics/topic", topic: @question.topic
end
