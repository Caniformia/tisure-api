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

ActiveRecord::Schema.define(version: 2021_11_23_055957) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "subject_id", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "content", null: false
    t.boolean "is_answer", null: false
    t.integer "question_id", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "choices_records", id: false, force: :cascade do |t|
    t.integer "choice_id", null: false
    t.integer "record_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.string "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_comments_on_question_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "question_lists", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id", null: false
    t.string "visiblity"
    t.integer "forked_from_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["forked_from_id"], name: "index_question_lists_on_forked_from_id"
    t.index ["owner_id"], name: "index_question_lists_on_owner_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content", null: false
    t.boolean "is_multi_answer", null: false
    t.integer "chapter_id", null: false
    t.index ["chapter_id"], name: "index_questions_on_chapter_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_correct", null: false
    t.index ["question_id"], name: "index_records_on_question_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "choices", "questions"
  add_foreign_key "comments", "questions"
  add_foreign_key "comments", "users"
  add_foreign_key "question_lists", "question_lists", column: "forked_from_id"
  add_foreign_key "question_lists", "users", column: "owner_id"
  add_foreign_key "questions", "chapters"
  add_foreign_key "records", "questions"
  add_foreign_key "records", "users"
end
