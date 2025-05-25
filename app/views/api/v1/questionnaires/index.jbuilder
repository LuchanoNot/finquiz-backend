# frozen_string_literal: true

json.array! @questionnaires do |questionnaire|
  json.partial! "questionnaire", questionnaire: questionnaire
  json.units questionnaire.units do |unit|
    json.partial! "api/v1/units/unit", unit: unit
  end
end
