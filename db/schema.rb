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

ActiveRecord::Schema.define(version: 2019_07_14_151349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "date", null: false
    t.string "category"
    t.string "notes"
    t.boolean "attended"
    t.boolean "paid"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "prep_time"
    t.string "ingredients", default: [], array: true
    t.string "image_name"
    t.string "description"
    t.string "directions"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "cell"
    t.string "home_phone"
    t.string "email"
    t.string "password_digest"
    t.text "patient_notes"
    t.integer "past_appointments_count"
    t.integer "appointments_missed"
    t.integer "appointments_canceled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
