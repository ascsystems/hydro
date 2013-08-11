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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130808232327) do

  create_table "accounts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "title"
    t.string   "meta_description"
    t.string   "keywords"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "title"
    t.string   "meta_description"
    t.string   "keywords"
  end

  create_table "category_products", :force => true do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.integer  "order_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "line_item_options", :force => true do |t|
    t.integer  "line_item_id"
    t.integer  "option_id"
    t.string   "option_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "quantity",     :default => 1
    t.integer  "order_id"
    t.string   "product_name"
  end

  create_table "mailing_lists", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "option_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "template"
  end

  create_table "option_values", :force => true do |t|
    t.integer  "option_id"
    t.string   "name"
    t.integer  "order_num"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "display_data"
  end

  create_table "options", :force => true do |t|
    t.string   "name"
    t.integer  "order_num"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "option_type_id"
    t.integer  "product_type_id"
  end

  create_table "orders", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "shipping_method_id"
    t.string   "billing_first_name"
    t.string   "billing_last_name"
    t.string   "billing_address"
    t.string   "billing_address2"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "slug",             :null => false
    t.text     "header_content"
    t.text     "right_content"
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "keywords"
  end

  create_table "product_images", :force => true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "path"
    t.integer  "default_image"
  end

  create_table "product_option_value_images", :force => true do |t|
    t.integer  "product_option_value_id"
    t.integer  "product_image_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "product_option_values", :force => true do |t|
    t.integer  "option_value_id"
    t.integer  "product_id"
    t.decimal  "price",           :precision => 10, :scale => 0
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",            :precision => 10, :scale => 2
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "product_type_id"
    t.integer  "brand_id"
    t.string   "short_name"
    t.string   "title"
    t.string   "meta_description"
    t.string   "keywords"
  end

  create_table "related_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "related_product_id"
    t.integer  "order_num"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.integer  "rating"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
