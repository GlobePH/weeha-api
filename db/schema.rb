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

ActiveRecord::Schema.define(version: 20160723212035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "lat"
    t.string   "lng"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_locations_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.string   "status",      default: "pending"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "code"
    t.boolean  "verified"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tokens_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "mobile_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "gender"
    t.datetime "birth_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "username"
    t.string   "access_token"
    t.boolean  "verified",      default: false
  end

  add_foreign_key "locations", "users"
  add_foreign_key "tokens", "users"
end
