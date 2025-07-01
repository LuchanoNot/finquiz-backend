# frozen_string_literal: true

json.course do
  json.partial! "course", course: @course
end

json.general_stats do
  json.average_completed_questionnaires_per_student @course.average_completed_questionnaires_per_student
  json.average_result @course.average_result
  json.best_result_topic @course.best_result_topic
  json.worst_result_topic @course.worst_result_topic
  json.active_students @course.active_students
end

json.students_stats @students do |student|
  json.extract! student, :id, :name

  json.recent_questionnaires student.completed_questionnaires.last(5) do |questionnaire|
    json.extract! questionnaire, :id, :name, :result
    json.created_at questionnaire.formatted_created_at
    json.units questionnaire.units do |unit|
      json.partial! "api/v1/units/unit", unit:
    end
  end

  json.completed_questionnaires_count student.completed_questionnaires.count
  json.average_result student.average_result
  json.success_topics student.success_topics
  json.failure_topics student.failure_topics
  json.correctly_answered_questions_count student.correctly_answered_questions_count
  json.incorrectly_answered_questions_count student.incorrectly_answered_questions_count
end

json.pagination do
  json.current_page @students.current_page
  json.next_page @students.next_page
  json.prev_page @students.prev_page
  json.total_pages @students.total_pages
end
