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

ActiveRecord::Schema.define(version: 20190430055303) do

  create_table "catalog_courses", force: :cascade do |t|
    t.integer "catalog_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalog_id"], name: "index_catalog_courses_on_catalog_id"
    t.index ["course_id"], name: "index_catalog_courses_on_course_id"
  end

  create_table "catalogs", force: :cascade do |t|
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "requirement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requirement_id"], name: "index_categories_on_requirement_id"
  end

  create_table "category_courses", force: :cascade do |t|
    t.integer "category_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_courses_on_category_id"
    t.index ["course_id"], name: "index_category_courses_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.string "description"
    t.integer "credit_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "majors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plan_courses", force: :cascade do |t|
    t.integer "plan_id"
    t.integer "course_id"
    t.string "term"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_plan_courses_on_course_id"
    t.index ["plan_id"], name: "index_plan_courses_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "year"
    t.string "current_semester"
    t.string "current_year"
    t.integer "major_id"
    t.index ["major_id"], name: "index_plans_on_major_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.integer "major_id"
    t.integer "catalog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalog_id"], name: "index_requirements_on_catalog_id"
    t.index ["major_id"], name: "index_requirements_on_major_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
