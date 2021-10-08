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

ActiveRecord::Schema.define(version: 2021_10_08_151046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.bigint "season_id", null: false
    t.bigint "edition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["edition_id"], name: "index_articles_on_edition_id"
    t.index ["season_id"], name: "index_articles_on_season_id"
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name", null: false
    t.string "kind", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "award_win", default: 3
    t.integer "award_draw", default: 1
    t.integer "award_loss", default: 0
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

  create_table "games", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.bigint "stadium_id"
    t.date "alternative_date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["schedule_id"], name: "index_games_on_schedule_id"
    t.index ["stadium_id"], name: "index_games_on_stadium_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "game_id", null: false
    t.integer "mark"
    t.integer "penalty_mark"
    t.integer "points_award"
    t.boolean "forfeit", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_results_on_game_id"
    t.index ["team_id"], name: "index_results_on_team_id"
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

  create_table "stadiums", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "kind"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "editions"
  add_foreign_key "articles", "seasons"
  add_foreign_key "contestants", "editions"
  add_foreign_key "contestants", "teams"
  add_foreign_key "editions", "competitions"
  add_foreign_key "editions", "seasons"
  add_foreign_key "games", "schedules"
  add_foreign_key "games", "stadiums"
  add_foreign_key "results", "games"
  add_foreign_key "results", "teams"
  add_foreign_key "schedules", "editions"
  add_foreign_key "team_names", "teams"
end
