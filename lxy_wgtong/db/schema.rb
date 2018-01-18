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

ActiveRecord::Schema.define(version: 20180118015306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cultures", force: :cascade do |t|
    t.text "pic1"
    t.text "pic2"
    t.text "pic3"
    t.text "pic4"
    t.text "title"
    t.text "time"
    t.text "place"
    t.text "company"
    t.text "kind"
    t.text "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "title"
    t.text "time"
    t.text "place"
    t.text "company"
    t.text "kind"
    t.text "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.text "pic"
    t.text "message_id"
    t.text "counts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
