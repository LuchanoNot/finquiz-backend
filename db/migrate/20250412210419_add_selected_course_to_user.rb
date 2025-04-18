# frozen_string_literal: true

class AddSelectedCourseToUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :selected_course, foreign_key: { to_table: :courses }
  end
end
