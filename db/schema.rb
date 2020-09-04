# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_04_032139) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "course_subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "subject_id"
    t.integer "course_id"
    t.integer "status"
    t.datetime "start_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "priority"
    t.index ["course_id"], name: "index_course_subjects_on_course_id"
    t.index ["subject_id", "course_id"], name: "index_course_subjects_on_subject_id_and_course_id", unique: true
    t.index ["subject_id"], name: "index_course_subjects_on_subject_id"
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "note"
    t.string "image"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "positions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "program_languages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "work_done"
    t.text "issue"
    t.text "tomorrow_plan"
    t.date "date_of_report"
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_reports_on_course_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.float "duration"
    t.string "image"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_tasks_on_subject_id"
  end

  create_table "topic_subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "topic_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_topic_subjects_on_subject_id"
    t.index ["topic_id"], name: "index_topic_subjects_on_topic_id"
  end

  create_table "topics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_course_subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.date "deadline"
    t.integer "status"
    t.bigint "user_id", null: false
    t.bigint "course_subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "progress", default: 0.0
    t.index ["course_subject_id"], name: "index_user_course_subjects_on_course_subject_id"
    t.index ["user_id"], name: "index_user_course_subjects_on_user_id"
  end

  create_table "user_courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "progress", default: 0.0
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "user_tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "status"
    t.bigint "task_id", null: false
    t.bigint "user_course_subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_user_tasks_on_task_id"
    t.index ["user_course_subject_id"], name: "index_user_tasks_on_user_course_subject_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "date_of_birth"
    t.integer "staff_type"
    t.string "address"
    t.integer "gender"
    t.bigint "program_language_id", null: false
    t.bigint "position_id", null: false
    t.bigint "department_id", null: false
    t.bigint "school_id", null: false
    t.bigint "office_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0
    t.string "image"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["office_id"], name: "index_users_on_office_id"
    t.index ["position_id"], name: "index_users_on_position_id"
    t.index ["program_language_id"], name: "index_users_on_program_language_id"
    t.index ["role"], name: "index_users_on_role"
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "reports", "courses"
  add_foreign_key "reports", "users"
  add_foreign_key "tasks", "subjects"
  add_foreign_key "topic_subjects", "subjects"
  add_foreign_key "topic_subjects", "topics"
  add_foreign_key "user_course_subjects", "course_subjects"
  add_foreign_key "user_course_subjects", "users"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
  add_foreign_key "user_tasks", "tasks"
  add_foreign_key "user_tasks", "user_course_subjects"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "offices"
  add_foreign_key "users", "positions"
  add_foreign_key "users", "program_languages"
  add_foreign_key "users", "schools"
end
