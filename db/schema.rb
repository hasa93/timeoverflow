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

ActiveRecord::Schema.define(version: 20150330200315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_trgm"

  create_table "accounts", force: :cascade do |t|
    t.integer  "accountable_id"
    t.string   "accountable_type",    limit: 255
    t.integer  "balance"
    t.integer  "max_allowed_balance"
    t.integer  "min_allowed_balance"
    t.boolean  "flagged"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["accountable_id", "accountable_type"], name: "index_accounts_on_accountable_id_and_accountable_type", using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.hstore   "name_translations"
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "documentable_id"
    t.string   "documentable_type", limit: 255
    t.text     "title"
    t.text     "content"
    t.string   "label",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["documentable_id", "documentable_type"], name: "index_documents_on_documentable_id_and_documentable_type", using: :btree
  add_index "documents", ["label"], name: "index_documents_on_label", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "manager"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "entry_date"
    t.integer  "member_uid"
    t.boolean  "active",          default: true
  end

  add_index "members", ["organization_id"], name: "index_members_on_organization_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "movements", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "transfer_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movements", ["account_id"], name: "index_movements_on_account_id", using: :btree
  add_index "movements", ["transfer_id"], name: "index_movements_on_transfer_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "reg_number_seq"
    t.string   "theme",                limit: 255
    t.string   "email",                limit: 255
    t.string   "phone",                limit: 255
    t.string   "web",                  limit: 255
    t.text     "public_opening_times"
    t.text     "description"
    t.text     "address"
    t.string   "neighborhood",         limit: 255
    t.string   "city",                 limit: 255
    t.string   "domain",               limit: 255
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.string   "type",            limit: 255
    t.integer  "category_id"
    t.integer  "user_id"
    t.text     "description"
    t.date     "start_on"
    t.date     "end_on"
    t.boolean  "permanent"
    t.boolean  "joinable"
    t.boolean  "global"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "tags",                                                    array: true
    t.integer  "publisher_id"
    t.integer  "organization_id"
    t.boolean  "active",                      default: true
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree
  add_index "posts", ["organization_id"], name: "index_posts_on_organization_id", using: :btree
  add_index "posts", ["publisher_id"], name: "index_posts_on_publisher_id", using: :btree
  add_index "posts", ["tags"], name: "index_posts_on_tags", using: :gin
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "transfers", force: :cascade do |t|
    t.integer  "post_id"
    t.text     "reason"
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transfers", ["operator_id"], name: "index_transfers_on_operator_id", using: :btree
  add_index "transfers", ["post_id"], name: "index_transfers_on_post_id", using: :btree

  create_table "user_joined_post", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255,                null: false
    t.string   "email",                  limit: 255,                null: false
    t.string   "password_digest",        limit: 255
    t.date     "date_of_birth"
    t.string   "identity_document",      limit: 255
    t.string   "phone",                  limit: 255
    t.string   "alt_phone",              limit: 255
    t.text     "address"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.datetime "deleted_at"
    t.string   "gender",                 limit: 255
    t.text     "description"
    t.datetime "terms_accepted_at"
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.boolean  "active",                             default: true
    t.string   "locale",                             default: "es"
    t.boolean  "notifications",                      default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
