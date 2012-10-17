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

ActiveRecord::Schema.define(:version => 20121016001008) do

  create_table "activations", :force => true do |t|
    t.string   "title",           :null => false
    t.string   "location",        :null => false
    t.text     "description",     :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "body",          :null => false
    t.integer  "user_id",       :null => false
    t.integer  "activation_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name",                  :null => false
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "phone"
    t.string   "primary_contact_name",  :null => false
    t.string   "primary_contact_phone", :null => false
    t.string   "primary_contact_email"
    t.text     "emergency_role",        :null => false
    t.string   "employee_count_range"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "zip_code"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",                                     :null => false
    t.boolean  "wants_email_notifications", :default => true, :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "organization_id",                                      :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "emergency_role"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "mobile_phone_number"
    t.string   "landline_phone_number"
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
