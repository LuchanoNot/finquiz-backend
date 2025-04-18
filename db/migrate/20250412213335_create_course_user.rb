class CreateCourseUser < ActiveRecord::Migration[8.0]
  def change
    create_table :course_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end

    add_index :course_users, [ :user_id, :course_id ], unique: true
  end
end
