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

ActiveRecord::Schema.define(version: 20170528190806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string   "text"
    t.integer  "sentence_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["sentence_id"], name: "index_answers_on_sentence_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books_themes", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "theme_id"
    t.index ["book_id"], name: "index_books_themes_on_book_id", using: :btree
    t.index ["theme_id"], name: "index_books_themes_on_theme_id", using: :btree
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "title"
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_exercises_on_unit_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "sentences", force: :cascade do |t|
    t.text     "text"
    t.boolean  "has_specific_answer"
    t.integer  "exercise_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["exercise_id"], name: "index_sentences_on_exercise_id", using: :btree
  end

  create_table "themes", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "theories", force: :cascade do |t|
    t.string   "image"
    t.string   "links"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "title"
    t.integer  "number"
    t.integer  "theory_id"
    t.integer  "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id"], name: "index_units_on_theme_id", using: :btree
    t.index ["theory_id"], name: "index_units_on_theory_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",       null: false
    t.string   "lastname",        null: false
    t.string   "email_address",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true, using: :btree
  end

  add_foreign_key "answers", "sentences"
  add_foreign_key "exercises", "units"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "sentences", "exercises"
  add_foreign_key "units", "themes"
  add_foreign_key "units", "theories"
end
