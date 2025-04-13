# frozen_string_literal: true

class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, uniqueness: { scope: :course_id, message: "ya enrolado en este curso" }
end
