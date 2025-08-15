# frozen_string_literal: true

json.extract! @questionnaire, :id, :current_position, :name

json.stats @questionnaire.stats

json.topics @questionnaire.topics do |topic|
  json.partial! "api/v1/topics/topic", topic:
end

json.questions @questionnaire.questionnaires_questions.in_order do |questionnaire_question|
  json.id questionnaire_question.question_id
  json.stem questionnaire_question.question.stem
  json.correct questionnaire_question.correct
  json.answered_option_id questionnaire_question.answered_option_id
  json.score questionnaire_question.question.score

  json.explanation questionnaire_question.question.correct_option.explanation

  json.topic do
    json.partial! "api/v1/topics/topic", topic: questionnaire_question.question.topic
  end

  json.options questionnaire_question.question.options do |option|
    json.id option.id
    json.text option.text
    json.correct option.correct
  end
end
