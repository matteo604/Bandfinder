# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_10_26_102551) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.bigint "band_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["band_id"], name: "index_applications_on_band_id"
    t.index ["session_id"], name: "index_applications_on_session_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "bands", force: :cascade do |t|
    t.string "title", null: false
    t.string "address", null: false
    t.string "genre"
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.bigint "leader_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leader_id"], name: "index_bands_on_leader_id"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "band_leader_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_leader_id"], name: "index_chats_on_band_leader_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "band_id", null: false
    t.integer "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_reviews_on_band_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.bigint "creator_id", null: false
    t.bigint "band_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_sessions_on_band_id"
    t.index ["creator_id"], name: "index_sessions_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "telephone_number", null: false
    t.string "instrument", null: false
    t.string "address", null: false
    t.boolean "leader"
    t.string "status"
    t.float "latitude"
    t.float "longitude"
    t.bigint "band_id"
    t.index ["band_id"], name: "index_users_on_band_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "applications", "bands"
  add_foreign_key "applications", "sessions"
  add_foreign_key "applications", "users"
  add_foreign_key "bands", "users", column: "leader_id"
  add_foreign_key "chats", "bands", column: "band_leader_id"
  add_foreign_key "chats", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "bands"
  add_foreign_key "reviews", "users"
  add_foreign_key "sessions", "bands"
  add_foreign_key "sessions", "users", column: "creator_id"
  add_foreign_key "users", "bands"
end
