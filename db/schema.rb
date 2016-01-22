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

ActiveRecord::Schema.define(version: 20160122201826) do

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  add_index "categories_products", ["category_id"], name: "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], name: "index_categories_products_on_product_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "shipped",    default: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.string   "email"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "cc_num"
    t.date     "cc_exp"
    t.integer  "cc_cvv"
    t.string   "cc_name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "status",          default: "paid"
    t.string   "shipping_choice"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "user_id"
    t.string   "photo_url"
    t.integer  "stock"
    t.string   "description"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "weight"
    t.integer  "diameter"
    t.integer  "width"
    t.integer  "height"
    t.integer  "length"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.integer  "product_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "reviews", ["product_id"], name: "index_reviews_on_product_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "country",         default: "US"
    t.string   "state"
    t.string   "city"
    t.integer  "zip"
  end

end
