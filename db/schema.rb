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

ActiveRecord::Schema[7.1].define(version: 2024_01_11_162703) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.integer "rows"
    t.integer "columns"
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_seating_chart_id"
    t.index ["current_seating_chart_id"], name: "index_classrooms_on_current_seating_chart_id"
    t.index ["teacher_id"], name: "index_classrooms_on_teacher_id"
  end

  create_table "classrooms_students", id: false, force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "student_id", null: false
    t.index ["classroom_id", "student_id"], name: "index_classrooms_students_on_classroom_id_and_student_id"
    t.index ["student_id", "classroom_id"], name: "index_classrooms_students_on_student_id_and_classroom_id"
  end

  create_table "desks", force: :cascade do |t|
    t.string "row_position"
    t.string "column_position"
    t.bigint "seating_chart_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seating_chart_id"], name: "index_desks_on_seating_chart_id"
    t.index ["student_id"], name: "index_desks_on_student_id"
  end

  create_table "seating_charts", force: :cascade do |t|
    t.string "title"
    t.integer "rows"
    t.integer "columns"
    t.bigint "classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_seating_charts_on_classroom_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  add_foreign_key "classrooms", "seating_charts", column: "current_seating_chart_id"
  add_foreign_key "classrooms", "teachers"
  add_foreign_key "desks", "seating_charts"
  add_foreign_key "desks", "students"
  add_foreign_key "seating_charts", "classrooms"
end
