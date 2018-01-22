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

ActiveRecord::Schema.define(version: 20180121155739) do

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "address"
    t.decimal "price_low"
    t.decimal "price_high"
    t.date "event_date"
    t.integer "max_seats_number"
    t.boolean "adults_only"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status_id", default: 1
    t.integer "user_id"
    t.index ["status_id"], name: "index_events_on_status_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.boolean "only_admin", default: false
    t.boolean "only_logged", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "seat_id_seq"
    t.decimal "price"
    t.string "email_address"
    t.date "sale_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.integer "event_id"
    t.integer "user_id"
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
    t.boolean "is_admin", default: false
    t.string "name"
    t.string "address"
    t.string "phone"
    t.decimal "money", default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
