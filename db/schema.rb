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

ActiveRecord::Schema.define(version: 2018_04_11_144529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "floofs", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_floofs_on_name", unique: true
  end

  create_table "walkers", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_walkers_on_name", unique: true
  end

  create_table "walks", force: :cascade do |t|
    t.bigint "floof_id"
    t.bigint "walker_id"
    t.string "day", null: false
    t.index ["floof_id"], name: "index_walks_on_floof_id"
    t.index ["walker_id"], name: "index_walks_on_walker_id"
  end

end
