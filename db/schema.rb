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

ActiveRecord::Schema.define(:version => 20110206130647) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "type",       :limit => 30
    t.string   "key"
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_tokens", ["key"], :name => "index_access_tokens_on_key", :unique => true

  create_table "internships", :force => true do |t|
    t.string   "semester"
    t.string   "year"
    t.string   "industry"
    t.string   "company_name"
    t.string   "job_field"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "website"
    t.text     "responsibilities"
    t.text     "review"
    t.text     "description"
    t.text     "requirements"
    t.boolean  "paid"
    t.boolean  "full_time"
    t.text     "search_string"
    t.date     "deadline"
    t.boolean  "available"
    t.boolean  "past"
    t.string   "name"
    t.integer  "user_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "internships", ["user_id"], :name => "index_internships_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "collection"
    t.string   "value"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login",               :limit => 40
    t.string   "email",               :limit => 100
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                                     :null => false
    t.string   "single_access_token",                                   :null => false
    t.string   "perishable_token",                                      :null => false
    t.integer  "login_count",                        :default => 0,     :null => false
    t.integer  "failed_login_count",                 :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "active_token_id"
    t.string   "url"
    t.string   "name"
    t.string   "username"
    t.boolean  "admin",                              :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "major"
    t.string   "yog"
    t.string   "linkedin"
    t.string   "search_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["active_token_id"], :name => "index_users_on_active_token_id"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
