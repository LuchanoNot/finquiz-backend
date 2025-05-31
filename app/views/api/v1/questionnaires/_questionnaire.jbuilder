# frozen_string_literal: true

json.extract! questionnaire, :id, :name, :current_position, :result
json.created_at questionnaire.formatted_created_at
