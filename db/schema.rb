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

ActiveRecord::Schema.define(:version => 20130923092359) do

  create_table "accounts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "their_role",             :limit => 50
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email", :unique => true
  add_index "accounts", ["reset_password_token"], :name => "index_accounts_on_reset_password_token", :unique => true

  create_table "ambassadors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "discipline"
    t.string   "image_path"
    t.text     "bio"
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

  create_table "cart_related_products", :force => true do |t|
    t.string   "product_id"
    t.string   "related_product_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "account_id"
    t.integer  "shipping_method_id"
  end

  add_index "carts", ["account_id"], :name => "index_carts_on_account_id"

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

  create_table "charities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "logo"
    t.integer  "featured"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "donations", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "serial_number"
    t.string   "place_of_purchase"
    t.string   "flask_purchased"
    t.integer  "charity_id"
    t.integer  "newsletter"
    t.text     "comments"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "email_subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.string   "email_address", :limit => 50
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "email_subscriptions", ["user_id"], :name => "index_email_subscriptions_on_user_id"

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
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.integer  "quantity",                                        :default => 1
    t.integer  "order_id"
    t.string   "product_name"
    t.integer  "product_image_id"
    t.decimal  "product_price",    :precision => 10, :scale => 0
    t.integer  "netsuite_id"
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
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "account_id"
    t.integer  "invoice_number"
    t.string   "status"
    t.decimal  "payment_total_cost", :precision => 8, :scale => 2
    t.string   "phone"
  end

  add_index "orders", ["account_id"], :name => "index_orders_on_account_id"

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

  create_table "product_translations", :force => true do |t|
    t.string   "sku"
    t.string   "description"
    t.decimal  "price",            :precision => 10, :scale => 2
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "netsuite_id"
    t.integer  "quantity"
    t.integer  "product_image_id"
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

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

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

  create_table "shipping_cost_rates", :force => true do |t|
    t.string   "country",         :limit => 25
    t.string   "state",           :limit => 25
    t.string   "zip",             :limit => 50
    t.decimal  "total_cost_tier",               :precision => 8, :scale => 2
    t.decimal  "shipping_cost",                 :precision => 8, :scale => 2
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  add_index "shipping_cost_rates", ["state"], :name => "index_shipping_cost_rates_on_state"

  create_table "shippings", :force => true do |t|
    t.string   "display_text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "cost"
  end

  create_table "state_tax_rates", :force => true do |t|
    t.integer  "tax_rate"
    t.string   "state_acronym"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "phone"
    t.float    "lat",        :limit => 10
    t.float    "lng",        :limit => 10
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

end
