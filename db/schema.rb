# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120608122817) do

  create_table "cases", :force => true do |t|
    t.string   "title"
    t.text     "note"
    t.datetime "date_time"
    t.integer  "pair_id",    :precision => 38, :scale => 0
    t.integer  "task_id",    :precision => 38, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "chairs", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "faculty_id", :precision => 38, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "chairs", ["faculty_id"], :name => "index_chairs_on_faculty_id"

  create_table "courses", :force => true do |t|
    t.integer  "number",     :precision => 38, :scale => 0
    t.integer  "faculty_id", :precision => 38, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "courses", ["faculty_id"], :name => "index_courses_on_faculty_id"

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "faculties", :force => true do |t|
    t.string   "name"
    t.integer  "institute_id", :precision => 38, :scale => 0
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "grades", :force => true do |t|
    t.integer  "student_id", :precision => 38, :scale => 0
    t.integer  "pair_id",    :precision => 38, :scale => 0
    t.string   "mark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "grades", ["pair_id"], :name => "index_grades_on_pair_id"
  add_index "grades", ["student_id"], :name => "index_grades_on_student_id"

  create_table "groups", :force => true do |t|
    t.string   "number"
    t.integer  "chair_id",   :precision => 38, :scale => 0
    t.integer  "course_id",  :precision => 38, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "groups", ["chair_id"], :name => "index_groups_on_chair_id"

  create_table "groups_pairs", :id => false, :force => true do |t|
    t.integer "group_id", :precision => 38, :scale => 0
    t.integer "pair_id",  :precision => 38, :scale => 0
  end

  create_table "institutes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "military_ranks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pairs", :force => true do |t|
    t.integer  "subject_id",  :precision => 38, :scale => 0
    t.string   "pair_type"
    t.integer  "pair_number", :precision => 38, :scale => 0
    t.integer  "teacher_id",  :precision => 38, :scale => 0
    t.datetime "date_time"
    t.string   "place"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "pairs", ["teacher_id"], :name => "index_pairs_on_teacher_id"

  create_table "parameters", :force => true do |t|
    t.integer "task_id", :precision => 38, :scale => 0
    t.string  "entity"
    t.string  "name"
    t.string  "value"
  end

  add_index "parameters", ["task_id"], :name => "index_parameters_on_task_id"

  create_table "people", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "type"
    t.integer  "sex_id",               :precision => 38, :scale => 0
    t.integer  "military_rank_id",     :precision => 38, :scale => 0
    t.integer  "scientific_rank_id",   :precision => 38, :scale => 0
    t.integer  "scientific_degree_id", :precision => 38, :scale => 0
    t.integer  "post_id",              :precision => 38, :scale => 0
    t.integer  "chair_id",             :precision => 38, :scale => 0
    t.integer  "group_id",             :precision => 38, :scale => 0
    t.integer  "course_id",            :precision => 38, :scale => 0
    t.string   "telephone"
    t.string   "room"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "people", ["chair_id"], :name => "index_people_on_chair_id"
  add_index "people", ["course_id"], :name => "index_people_on_course_id"
  add_index "people", ["group_id"], :name => "index_people_on_group_id"
  add_index "people", ["military_rank_id"], :name => "i_people_military_rank_id"
  add_index "people", ["post_id"], :name => "index_people_on_post_id"
  add_index "people", ["scientific_degree_id"], :name => "i_people_scientific_degree_id"
  add_index "people", ["scientific_rank_id"], :name => "i_people_scientific_rank_id"
  add_index "people", ["sex_id"], :name => "index_people_on_sex_id"

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scientific_degrees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scientific_ranks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "user_id",      :precision => 38, :scale => 0
    t.string   "name"
    t.boolean  "status",       :precision => 1,  :scale => 0
    t.string   "type"
    t.integer  "task_id",      :precision => 38, :scale => 0
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.datetime "completed_at"
  end

  add_index "tasks", ["task_id"], :name => "index_tasks_on_task_id"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "type"
    t.string   "email"
    t.string   "password"
    t.boolean  "activated",  :precision => 1,  :scale => 0
    t.integer  "person_id",  :precision => 38, :scale => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["person_id"], :name => "index_users_on_person_id"

end
