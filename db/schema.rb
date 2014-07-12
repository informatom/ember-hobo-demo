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

ActiveRecord::Schema.define(version: 20140712120608) do

  create_table "consumableitems", force: true do |t|
    t.integer  "position"
    t.string   "product_number"
    t.string   "contract_type"
    t.string   "product_line"
    t.string   "description"
    t.integer  "amount"
    t.integer  "theyield"
    t.decimal  "wholesale_price", precision: 10, scale: 2
    t.integer  "term"
    t.integer  "consumption1"
    t.integer  "consumption2"
    t.integer  "consumption3"
    t.integer  "consumption4"
    t.integer  "consumption5"
    t.integer  "consumption6"
    t.decimal  "balance6",        precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contractitem_id"
  end

  add_index "consumableitems", ["contractitem_id"], name: "index_consumableitems_on_contractitem_id"

  create_table "contractitems", force: true do |t|
    t.integer  "position"
    t.string   "product_number"
    t.string   "description"
    t.integer  "amount"
    t.string   "unit"
    t.integer  "volume"
    t.decimal  "product_price",   precision: 10, scale: 2
    t.decimal  "vat",             precision: 10, scale: 2
    t.decimal  "value",           precision: 10, scale: 2
    t.decimal  "discount_abs",    precision: 10, scale: 2, default: 0.0
    t.integer  "term"
    t.date     "startdate"
    t.integer  "volume_bw"
    t.integer  "volume_color"
    t.decimal  "marge",           precision: 10, scale: 2
    t.decimal  "monitoring_rate", precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contract_id"
  end

  add_index "contractitems", ["contract_id"], name: "index_contractitems_on_contract_id"

  create_table "contracts", force: true do |t|
    t.integer  "runtime"
    t.integer  "term"
    t.date     "startdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
