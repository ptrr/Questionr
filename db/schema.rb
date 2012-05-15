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

ActiveRecord::Schema.define(:version => 20120515092712) do

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "options", :force => true do |t|
    t.string   "option_label"
    t.string   "option_value"
    t.integer  "question_id"
    t.string   "option_type"
    t.string   "order"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.string   "question_type"
    t.integer  "form_id"
    t.integer  "order"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "required"
    t.boolean  "multiselect"
  end

  create_table "user_responses", :force => true do |t|
    t.string   "value"
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "form_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
