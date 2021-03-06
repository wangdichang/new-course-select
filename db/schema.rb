# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_26_110003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
    t.integer "item_one"
    t.integer "item_two"
    t.integer "item_three"
    t.integer "item_four"
    t.integer "item_five"
    t.integer "item_six"
    t.integer "item_seven"
    t.integer "item_eight"
    t.integer "item_nine"
    t.integer "item_ten"
    t.integer "item_eleven"
    t.integer "item_twelve"
    t.integer "item_thirteen"
    t.integer "item_fourteen"
    t.integer "item_fifteen"
    t.integer "item_sixteen"
    t.integer "item_seventeen"
    t.text "comment_advantage"
    t.text "comment_disadvantage"
    t.boolean "commented", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "course_code"
    t.string "course_type"
    t.string "teaching_type"
    t.string "exam_type"
    t.string "credit"
    t.integer "limit_num"
    t.integer "student_num", default: 0
    t.string "class_room"
    t.string "course_time"
    t.string "course_week"
    t.string "course_score"
    t.integer "semester_id"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "open", default: false
    t.index ["semester_id"], name: "index_courses_on_semester_id"
  end

  create_table "grades", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
    t.integer "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "open", default: false
    t.index ["course_id"], name: "index_grades_on_course_id"
    t.index ["user_id"], name: "index_grades_on_user_id"
  end

  create_table "notices", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", id: :serial, force: :cascade do |t|
    t.string "info", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_open", default: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "num"
    t.string "major"
    t.string "department"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "teacher", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
