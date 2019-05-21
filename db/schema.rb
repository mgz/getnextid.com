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

ActiveRecord::Schema.define(version: 2019_05_12_072257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "name", null: false
    t.bigint "value", default: 0, null: false
    t.bigint "created_from_ip_id", null: false
    t.bigint "incremented_from_ip_id", null: false
    t.text "password", null: false
    t.text "read_password"
    t.index ["created_from_ip_id"], name: "index_counters_on_created_from_ip_id"
    t.index ["incremented_from_ip_id"], name: "index_counters_on_incremented_from_ip_id"
    t.index ["name"], name: "index_counters_on_name", unique: true
  end

  create_table "ips", force: :cascade do |t|
    t.inet "addr", null: false
    t.index ["addr"], name: "index_ips_on_addr", unique: true
  end

  add_foreign_key "counters", "ips", column: "created_from_ip_id"
  add_foreign_key "counters", "ips", column: "incremented_from_ip_id"
end
