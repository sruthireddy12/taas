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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150210063606) do

  create_table "application_browsers", force: true do |t|
    t.integer  "application_id"
    t.integer  "browser_id"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_type_id"
  end

  create_table "application_details", force: true do |t|
    t.string   "parameter"
    t.string   "value"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "creator"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "point_of_contact"
    t.string   "email"
    t.time     "prefered_contact_time"
    t.integer  "application_type_id"
    t.string   "technology"
    t.string   "database"
  end

  add_index "applications", ["organization_id"], name: "index_applications_on_organization_id", using: :btree

  create_table "applications_test_types", force: true do |t|
    t.integer "application_id"
    t.integer "test_type_id"
  end

  add_index "applications_test_types", ["application_id", "test_type_id"], name: "index_applications_test_types_on_application_id_and_test_type_id", using: :btree

  create_table "attachments", force: true do |t|
    t.string   "file_path"
    t.string   "file_type"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "browsers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credentials", force: true do |t|
    t.string   "role"
    t.string   "username"
    t.string   "password"
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credentials", ["application_id"], name: "index_credentials_on_application_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "domain"
  end

  create_table "permissions", force: true do |t|
    t.string   "subject_class"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", force: true do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  add_index "permissions_roles", ["permission_id", "role_id"], name: "index_permissions_roles_on_permission_id_and_role_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "referred_by"
    t.string   "mobile_number"
    t.string   "telephone_number"
    t.string   "gender"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "inquiry"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "organization_id"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "test_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.integer "application_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
