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

ActiveRecord::Schema.define(:version => 20120327022529) do

  create_table "password_resets", :force => true do |t|
    t.integer  "user_id"
    t.string   "uuid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "password_resets", ["user_id"], :name => "index_password_resets_on_user_id"

  create_table "records", :force => true do |t|
    t.integer  "retailer_id"
    t.string   "code"
    t.string   "name"
    t.text     "artwork_url"
    t.string   "genre"
    t.string   "rating"
    t.text     "description"
    t.date     "release_date"
    t.text     "url"
    t.string   "type"
    t.text     "result"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "records", ["retailer_id"], :name => "index_records_on_retailer_id"

  create_table "retailers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "search_results", :force => true do |t|
    t.integer  "search_id"
    t.integer  "record_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "acknowledged", :default => false
  end

  add_index "search_results", ["record_id"], :name => "index_search_results_on_record_id"
  add_index "search_results", ["search_id"], :name => "index_search_results_on_search_id"

  create_table "searches", :force => true do |t|
    t.integer  "retailer_id"
    t.text     "parameters"
    t.text     "response"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.boolean  "monitor_by_email", :default => false
  end

  add_index "searches", ["retailer_id"], :name => "index_searches_on_retailer_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
