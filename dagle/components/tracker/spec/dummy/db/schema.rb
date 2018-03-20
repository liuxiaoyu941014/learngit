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

ActiveRecord::Schema.define(version: 20161126054341) do

  create_table "tracker_actions", force: :cascade do |t|
    t.string   "name"
    t.string   "controller_path"
    t.string   "action_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "tracker_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracker_share_codes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["resource_type", "resource_id"], name: "index_tracker_share_codes_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_tracker_share_codes_on_user_id"
  end

  create_table "tracker_user_relations", force: :cascade do |t|
    t.integer  "master_id"
    t.integer  "slave_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["master_id"], name: "index_tracker_user_relations_on_master_id"
    t.index ["slave_id"], name: "index_tracker_user_relations_on_slave_id"
  end

  create_table "tracker_visits", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "action_id"
    t.integer  "user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "url"
    t.string   "referer"
    t.text     "payload"
    t.string   "user_agent"
    t.string   "ip_address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["action_id"], name: "index_tracker_visits_on_action_id"
    t.index ["resource_type", "resource_id"], name: "index_tracker_visits_on_resource_type_and_resource_id"
    t.index ["session_id"], name: "index_tracker_visits_on_session_id"
    t.index ["user_id"], name: "index_tracker_visits_on_user_id"
  end

end
