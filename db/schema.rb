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

ActiveRecord::Schema.define(version: 20160407231406) do

  create_table "checklist_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklist_entries", force: true do |t|
    t.integer  "checklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "content"
    t.boolean  "checked",      default: false
    t.datetime "finished"
    t.string   "completed_by"
  end

  create_table "checklists", force: true do |t|
    t.boolean  "public"
    t.integer  "user_id"
    t.datetime "started"
    t.datetime "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "template_name"
    t.integer  "ticket_number"
    t.text     "desc"
    t.integer  "checklist_category_id"
    t.boolean  "archived"
  end

  add_index "checklists", ["checklist_category_id"], name: "index_checklists_on_checklist_category_id"

  create_table "comments", force: true do |t|
    t.text     "content"
    t.string   "author"
    t.integer  "checklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "template_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_entries", force: true do |t|
    t.integer  "template_id"
    t.text     "content"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", force: true do |t|
    t.integer  "owner_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "checklist_count",      default: 0
    t.text     "desc"
    t.integer  "template_category_id"
    t.boolean  "force_private"
  end

  add_index "templates", ["template_category_id"], name: "index_templates_on_template_category_id"

  create_table "users", force: true do |t|
    t.string   "loginid"
    t.integer  "rm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
  end

  create_table "visits", force: true do |t|
    t.integer  "user_id"
    t.integer  "session_id"
    t.text     "ip_address"
    t.text     "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id"

end
