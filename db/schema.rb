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

ActiveRecord::Schema.define(version: 20170528135549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_foreign_key "exercises", "units"
  add_foreign_key "units", "themes"
  add_foreign_key "units", "theories"
end
