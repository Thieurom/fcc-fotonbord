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

ActiveRecord::Schema.define(version: 20170622072006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borden_fotons", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "foton_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "foton_id"], name: "index_borden_fotons_on_user_id_and_foton_id", unique: true, using: :btree
  end

  create_table "fotons", force: :cascade do |t|
    t.string   "source"
    t.text     "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "foton_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["foton_id"], name: "index_likes_on_foton_id", using: :btree
    t.index ["user_id", "foton_id"], name: "index_likes_on_user_id_and_foton_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nickname"
    t.index ["nickname"], name: "index_users_on_nickname", using: :btree
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  end

  add_foreign_key "likes", "fotons"
end
