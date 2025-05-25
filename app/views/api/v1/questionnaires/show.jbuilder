# frozen_string_literal: true

json.partial! "questionnaire", questionnaire: @questionnaire

json.questions @questionnaire.questionnaires_questions.in_order do |questionnaire_question|
  json.id questionnaire_question.question_id
  json.correct questionnaire_question.correct
end
