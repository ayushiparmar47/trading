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

ActiveRecord::Schema.define(version: 2020_12_29_060311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "authentication_tokens", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id"
    t.datetime "last_used_at"
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentication_tokens_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "expected_rate"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.text "message"
    t.text "reply_message"
    t.boolean "replyed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_letters", force: :cascade do |t|
    t.text "subject"
    t.text "content"
    t.string "image"
    t.boolean "publish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plan_subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_plan_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_plan_subscriptions_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "currency"
    t.integer "interval"
    t.integer "interval_count"
    t.string "stripe_plan_id"
    t.string "stripe_product_id"
  end

  create_table "referal_codes", force: :cascade do |t|
    t.string "referal_code"
    t.float "discount_percent"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "plan_id"
    t.string "stripe_customer_id"
    t.string "stripe_subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "today_trades", force: :cascade do |t|
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "for_free_plan"
    t.index ["company_id"], name: "index_today_trades_on_company_id"
  end

  create_table "user_analyzed_trades", force: :cascade do |t|
    t.bigint "today_trade_id"
    t.float "current_rate"
    t.bigint "user_id"
    t.float "gain_or_loss"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["today_trade_id"], name: "index_user_analyzed_trades_on_today_trade_id"
    t.index ["user_id"], name: "index_user_analyzed_trades_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.text "short_bio"
    t.boolean "news_letter"
    t.string "referral_code"
    t.boolean "subscribed", default: false
    t.integer "trading_exp"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authentication_tokens", "users"
  add_foreign_key "today_trades", "companies"
  add_foreign_key "user_analyzed_trades", "today_trades"
  add_foreign_key "user_analyzed_trades", "users"
end
