# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_12_05_004632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "casts", force: :cascade do |t|
    t.string "cast_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_files", force: :cascade do |t|
    t.string "content_file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string "title", null: false
    t.integer "type_content"
    t.string "show_id"
    t.datetime "published_at", null: false
    t.integer "year", null: false
    t.text "description", null: false
    t.integer "duration"
    t.integer "type_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "content_file_id", null: false
    t.integer "rating"
    t.bigint "director_id"
    t.index ["content_file_id"], name: "index_contents_on_content_file_id"
    t.index ["director_id"], name: "index_contents_on_director_id"
  end

  create_table "contents_casts", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.bigint "cast_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cast_id"], name: "index_contents_casts_on_cast_id"
    t.index ["content_id"], name: "index_contents_casts_on_content_id"
  end

  create_table "contents_countries", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_contents_countries_on_content_id"
    t.index ["country_id"], name: "index_contents_countries_on_country_id"
  end

  create_table "contents_genres", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_contents_genres_on_content_id"
    t.index ["genre_id"], name: "index_contents_genres_on_genre_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "country_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "genre_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contents", "casts", column: "director_id"
  add_foreign_key "contents", "content_files"
  add_foreign_key "contents_casts", "casts"
  add_foreign_key "contents_casts", "contents"
  add_foreign_key "contents_countries", "contents"
  add_foreign_key "contents_countries", "countries"
  add_foreign_key "contents_genres", "contents"
  add_foreign_key "contents_genres", "genres"
end
