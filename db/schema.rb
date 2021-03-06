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

ActiveRecord::Schema.define(version: 20150303065628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "mobile"
    t.boolean  "admin",                  default: false
  end

  add_index "agencies", ["email"], name: "index_agencies_on_email", unique: true, using: :btree
  add_index "agencies", ["reset_password_token"], name: "index_agencies_on_reset_password_token", unique: true, using: :btree

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "gyms", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "lang"
    t.float    "long"
    t.text     "address"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "featured",               default: false
    t.float    "rating",                 default: 0.0
    t.text     "facility"
    t.boolean  "verified",               default: false
    t.integer  "agency_id"
    t.string   "slug"
    t.string   "website"
    t.integer  "male_trainers"
    t.integer  "female_trainers"
    t.string   "email"
    t.string   "mobile"
    t.float    "registration_fee",       default: 0.0
    t.integer  "gender",                 default: 0
    t.string   "weekday_from"
    t.string   "weekday_to"
    t.string   "weekend_from"
    t.string   "weekend_to"
    t.boolean  "is_payment_enabled",     default: false
    t.text     "additional_info"
    t.text     "special_offers"
    t.string   "weekday_secondary_from"
    t.string   "weekday_secondary_to"
    t.string   "weekend_secondary_from"
    t.string   "weekend_secondary_to"
  end

  add_index "gyms", ["agency_id"], name: "index_gyms_on_agency_id", using: :btree
  add_index "gyms", ["slug"], name: "index_gyms_on_slug", using: :btree

  create_table "payments", force: true do |t|
    t.string   "mihpayid"
    t.string   "mode"
    t.string   "status"
    t.string   "txnid"
    t.string   "firstname"
    t.string   "email"
    t.string   "phone"
    t.integer  "gym_id"
    t.integer  "plan_id"
    t.string   "payuMoneyId"
    t.boolean  "transferred", default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "payments", ["gym_id"], name: "index_payments_on_gym_id", using: :btree

  create_table "pictures", force: true do |t|
    t.integer  "gym_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "pictures", ["gym_id"], name: "index_pictures_on_gym_id", using: :btree

  create_table "pricings", force: true do |t|
    t.integer  "duration"
    t.float    "price"
    t.integer  "gym_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "pricing_type", default: "regular"
  end

  add_index "pricings", ["gym_id"], name: "index_pricings_on_gym_id", using: :btree

  create_table "reviews", force: true do |t|
    t.string   "name"
    t.text     "comment"
    t.integer  "gym_id"
    t.float    "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["gym_id"], name: "index_reviews_on_gym_id", using: :btree

  add_foreign_key "gyms", "agencies"
  add_foreign_key "payments", "gyms"
  add_foreign_key "pictures", "gyms"
  add_foreign_key "pricings", "gyms"
  add_foreign_key "reviews", "gyms"
end
