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

ActiveRecord::Schema.define(version: 20141115042411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["winner_id"], name: "index_games_on_winner_id", using: :btree

  create_table "participations", force: true do |t|
    t.integer  "player_id",  null: false
    t.integer  "game_id",    null: false
    t.integer  "numbers",    null: false, array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["game_id"], name: "index_participations_on_game_id", using: :btree
  add_index "participations", ["player_id"], name: "index_participations_on_player_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
