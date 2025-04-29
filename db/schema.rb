# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_27_222033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "course_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_users_on_course_id"
    t.index ["user_id", "course_id"], name: "index_course_users_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_course_users_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.text "text", default: "", null: false
    t.boolean "correct", default: false, null: false
    t.text "explanation", default: "", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.integer "current_position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questionnaires_on_user_id"
  end

  create_table "questionnaires_questions", force: :cascade do |t|
    t.bigint "questionnaire_id", null: false
    t.bigint "question_id", null: false
    t.bigint "answered_option_id"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answered_option_id"], name: "index_questionnaires_questions_on_answered_option_id"
    t.index ["question_id"], name: "index_questionnaires_questions_on_question_id"
    t.index ["questionnaire_id"], name: "index_questionnaires_questions_on_questionnaire_id"
  end

  create_table "questionnaires_units", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.bigint "questionnaire_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_questionnaires_units_on_questionnaire_id"
    t.index ["unit_id"], name: "index_questionnaires_units_on_unit_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "stem", default: "", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.bigint "course_id", null: false
    t.integer "position", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_units_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.string "name"
    t.string "nickname"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.bigint "selected_course_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["selected_course_id"], name: "index_users_on_selected_course_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "course_users", "courses"
  add_foreign_key "course_users", "users"
  add_foreign_key "options", "questions"
  add_foreign_key "questionnaires", "users"
  add_foreign_key "questionnaires_questions", "options", column: "answered_option_id"
  add_foreign_key "questionnaires_questions", "questionnaires"
  add_foreign_key "questionnaires_questions", "questions"
  add_foreign_key "questionnaires_units", "questionnaires"
  add_foreign_key "questionnaires_units", "units"
  add_foreign_key "units", "courses"
  add_foreign_key "users", "courses", column: "selected_course_id"
end
