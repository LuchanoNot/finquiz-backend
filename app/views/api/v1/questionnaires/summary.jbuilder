# frozen_string_literal: true

json.extract! @questionnaire, :id, :current_position

json.questions @questionnaire.questionnaires_questions.in_order do |questionnaire_question|
  json.id questionnaire_question.question_id
  json.stem questionnaire_question.question.stem
  json.correct questionnaire_question.correct
  json.answered_option_id questionnaire_question.answered_option_id

  json.explanation questionnaire_question.question.correct_option.explanation

  json.options questionnaire_question.question.options do |option|
    json.id option.id
    json.text option.text
    json.correct option.correct
  end
end
