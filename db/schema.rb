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

ActiveRecord::Schema.define(version: 20150610215254) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "check_ins", force: :cascade do |t|
    t.integer  "item_id",     limit: 4,                null: false
    t.integer  "person_id",   limit: 4,                null: false
    t.boolean  "on_deadline", limit: 1, default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "check_ins", ["item_id", "person_id"], name: "index_check_ins_on_item_id_and_person_id", using: :btree

  create_table "check_outs", force: :cascade do |t|
    t.datetime "check_out_date"
    t.datetime "deadline_date"
    t.boolean  "released",       limit: 1, default: false
    t.integer  "item_id",        limit: 4,                 null: false
    t.integer  "person_id",      limit: 4,                 null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "check_outs", ["item_id", "person_id"], name: "index_check_outs_on_item_id_and_person_id", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.float    "cost",            limit: 24
    t.string   "condition",       limit: 255
    t.integer  "category_id",     limit: 4
    t.integer  "sub_category_id", limit: 4
    t.integer  "location_id",     limit: 4
    t.string   "photo",           limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "items", ["category_id", "sub_category_id"], name: "index_items_on_category_id_and_sub_category_id", using: :btree

  create_table "items_tags", id: false, force: :cascade do |t|
    t.integer "item_id", limit: 4, null: false
    t.integer "tag_id",  limit: 4, null: false
  end

  add_index "items_tags", ["item_id", "tag_id"], name: "index_items_tags_on_item_id_and_tag_id", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "loc1",        limit: 255
    t.string   "loc2",        limit: 255
    t.string   "loc3",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "nationalid",     limit: 255, null: false
    t.date     "birth_date"
    t.string   "first_name",     limit: 255
    t.string   "middle_name",    limit: 255
    t.string   "last_name",      limit: 255
    t.string   "addressA",       limit: 255
    t.string   "addressB",       limit: 255
    t.string   "addressC",       limit: 255
    t.string   "addressD",       limit: 255
    t.string   "phone_number",   limit: 255
    t.string   "mobile_number1", limit: 255
    t.string   "mobile_number2", limit: 255
    t.integer  "role_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "people", ["nationalid"], name: "index_people_on_nationalid", unique: true, using: :btree

  create_table "people_services", id: false, force: :cascade do |t|
    t.integer "person_id",  limit: 4, null: false
    t.integer "service_id", limit: 4, null: false
  end

  add_index "people_services", ["person_id", "service_id"], name: "index_people_services_on_person_id_and_service_id", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.integer  "person_id",   limit: 4,     null: false
    t.integer  "item_id",     limit: 4
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "sub_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "category_id", limit: 4,     null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255,              null: false
    t.integer  "person_id",              limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
