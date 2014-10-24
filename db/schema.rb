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

ActiveRecord::Schema.define(version: 20141008045354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.integer  "user_id",                    null: false
    t.string   "name",                       null: false
    t.string   "account_number"
    t.integer  "balance",        default: 0
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "account_id",                                          null: false
    t.decimal  "cash_flow",    precision: 20, scale: 4, default: 0.0
    t.datetime "receipt_date"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           limit: 100,              null: false
    t.string   "password_digest"
    t.string   "first_name",                  default: ""
    t.string   "last_name",                   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
