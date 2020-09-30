# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_30_134552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string "name", null: false
    t.string "kind", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "award_win", default: 3
    t.integer "award_draw", default: 1
    t.integer "award_lose", default: 0
    t.integer "award_forfeit", default: 0
    t.boolean "ratio_pts_by_match", default: false
  end

  create_table "contestants", force: :cascade do |t|
    t.bigint "edition_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["edition_id"], name: "index_contestants_on_edition_id"
    t.index ["team_id"], name: "index_contestants_on_team_id"
  end

  create_table "editions", force: :cascade do |t|
    t.bigint "competition_id", null: false
    t.bigint "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "second_legs_offset", default: 2
    t.integer "total_rounds"
    t.index ["competition_id"], name: "index_editions_on_competition_id"
    t.index ["season_id"], name: "index_editions_on_season_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "edition_id", null: false
    t.date "day", null: false
    t.string "designation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["edition_id"], name: "index_schedules_on_edition_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "years"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_names", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "used_since", null: false
    t.index ["team_id"], name: "index_team_names_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "contestants", "editions"
  add_foreign_key "contestants", "teams"
  add_foreign_key "editions", "competitions"
  add_foreign_key "editions", "seasons"
  add_foreign_key "schedules", "editions"
  add_foreign_key "team_names", "teams"
end
