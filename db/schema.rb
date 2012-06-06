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

ActiveRecord::Schema.define(:version => 20120530143553) do

  create_table "to_do_items", :force => true do |t|
    t.string   "subject",       :default => ""
    t.text     "content"
    t.string   "priority"
    t.date     "remind_on"
    t.time     "remind_at"
    t.integer  "to_do_list_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "to_do_lists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_id",   :default => ""
    t.string   "user_name"
    t.string   "password"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

end
