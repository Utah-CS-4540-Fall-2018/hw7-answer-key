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

ActiveRecord::Schema.define(version: 2018_11_26_024139) do

  create_table "famous_singers", force: :cascade do |t|
    t.string "name"
    t.float "range_in_octives"
    t.integer "age"
    t.string "band_name"
  end

  create_table "listing_searches", force: :cascade do |t|
    t.integer "search_id"
    t.integer "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_listing_searches_on_listing_id"
    t.index ["search_id"], name: "index_listing_searches_on_search_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.text "description"
    t.string "pricing"
    t.integer "listings_poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
    t.datetime "alerted_at"
    t.datetime "reviewed_at"
    t.boolean "walks_like_a_duck", default: false
    t.datetime "last_time_on_the_moon"
    t.integer "status"
    t.index ["listings_poll_id"], name: "index_listings_on_listings_poll_id"
  end

  create_table "listings_polls", force: :cascade do |t|
    t.boolean "is_automated"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.integer "user_id"
    t.string "keywords"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keyword_must_have"
    t.string "keyword_must_not_have"
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
