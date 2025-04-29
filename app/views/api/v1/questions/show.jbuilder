# frozen_string_literal: true

json.extract! @question, :id, :stem

json.options @question.options do |option|
  json.extract! option, :id, :text
end
