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

ActiveRecord::Schema.define(:version => 20110202232631) do

  create_table "answers", :force => true do |t|
    t.text     "body",                           :null => false
    t.boolean  "correct",     :default => false, :null => false
    t.integer  "question_id",                    :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "categories", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories_questions", :id => false, :force => true do |t|
    t.integer "question_id", :null => false
    t.integer "category_id", :null => false
  end

  add_index "categories_questions", ["category_id"], :name => "index_categories_questions_on_category_id"
  add_index "categories_questions", ["question_id"], :name => "index_categories_questions_on_question_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "exam_questions", :force => true do |t|
    t.integer  "exam_id",                        :null => false
    t.integer  "question_id",                    :null => false
    t.boolean  "answer1",     :default => false, :null => false
    t.boolean  "answer2",     :default => false, :null => false
    t.boolean  "answer3",     :default => false, :null => false
    t.boolean  "answer4",     :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "state"
    t.boolean  "accurate"
  end

  add_index "exam_questions", ["exam_id"], :name => "index_exam_questions_on_exam_id"
  add_index "exam_questions", ["question_id"], :name => "index_exam_questions_on_question_id"

  create_table "exams", :force => true do |t|
    t.string   "sessionid",    :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "state"
    t.datetime "completed_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.boolean  "active",      :default => true, :null => false
    t.string   "category"
    t.text     "body"
    t.string   "author"
    t.integer  "question_id",                   :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "questions", :force => true do |t|
    t.text     "body",                          :null => false
    t.boolean  "active",     :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.text     "comment"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
