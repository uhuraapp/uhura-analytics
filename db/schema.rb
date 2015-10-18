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

ActiveRecord::Schema.define(version: 20151018020640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ahoy_events", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.json     "properties"
    t.datetime "time"
  end

  add_index "ahoy_events", ["time"], name: "index_ahoy_events_on_time", using: :btree
  add_index "ahoy_events", ["user_id"], name: "index_ahoy_events_on_user_id", using: :btree
  add_index "ahoy_events", ["visit_id"], name: "index_ahoy_events_on_visit_id", using: :btree

  create_table "ahoy_messages", force: :cascade do |t|
    t.string   "token"
    t.text     "to"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "mailer"
    t.text     "subject"
    t.text     "content"
    t.datetime "sent_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
  end

  add_index "ahoy_messages", ["token"], name: "index_ahoy_messages_on_token", using: :btree
  add_index "ahoy_messages", ["user_id", "user_type"], name: "index_ahoy_messages_on_user_id_and_user_type", using: :btree

  create_table "blazer_audits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "query_id"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.integer  "query_id"
    t.string   "state"
    t.text     "emails"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.integer  "dashboard_id"
    t.integer  "query_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.text     "description"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", id: :bigserial, force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "uri"
  end

  add_index "categories", ["name"], name: "categories_name_key", unique: true, using: :btree

  create_table "categorys", id: :bigserial, force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorys", ["name"], name: "categorys_name_key", unique: true, using: :btree

  create_table "channel_categories", id: :bigserial, force: :cascade do |t|
    t.integer "channel_id",  limit: 8
    t.integer "category_id", limit: 8
  end

  add_index "channel_categories", ["channel_id", "category_id"], name: "idx_categoriable", using: :btree

  create_table "channel_urls", id: :bigserial, force: :cascade do |t|
    t.integer  "channel_id", limit: 8
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "i_d",        limit: 8
  end

  add_index "channel_urls", ["channel_id"], name: "idx_channel_urls_channel_id", using: :btree
  add_index "channel_urls", ["url"], name: "idx_channel_url_url", unique: true, using: :btree
  add_index "channel_urls", ["url"], name: "uix_channel_urls_url", unique: true, using: :btree

  create_table "channels", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.text     "image_url"
    t.text     "copyright"
    t.text     "last_build_date"
    t.text     "url",                           null: false
    t.text     "uri"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "language"
    t.text     "link"
    t.boolean  "loading"
    t.datetime "deleted_at"
    t.text     "colors"
    t.integer  "subscriptions_count"
    t.integer  "episodes_count"
    t.text     "image_data"
    t.datetime "visited_at"
    t.integer  "i_d",                 limit: 8
    t.boolean  "enabled"
  end

  add_index "channels", ["uri"], name: "idx_channel_uri", using: :btree
  add_index "channels", ["url"], name: "channels_url_key", unique: true, using: :btree
  add_index "channels", ["url"], name: "idx_channel_url", using: :btree

  create_table "items", force: :cascade do |t|
    t.text     "key"
    t.text     "source_url",                 null: false
    t.text     "title",                      null: false
    t.text     "description"
    t.integer  "channel_id"
    t.datetime "published_at",               null: false
    t.text     "duration"
    t.text     "uri"
    t.text     "type"
    t.integer  "content_length", limit: 8
    t.string   "content_type",   limit: 255
    t.integer  "stopped_at",     limit: 8
  end

  add_index "items", ["channel_id", "id"], name: "suggestions", using: :btree
  add_index "items", ["channel_id", "published_at"], name: "idx_episode_channel_id_with_published_at", using: :btree
  add_index "items", ["channel_id"], name: "idx_episode_channel_id", using: :btree
  add_index "items", ["channel_id"], name: "index1", using: :btree
  add_index "items", ["key"], name: "items_key_key", unique: true, using: :btree
  add_index "items", ["source_url"], name: "items_source_url_key", unique: true, using: :btree

  create_table "user_channels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_channels", ["channel_id", "user_id"], name: "subscriptions", using: :btree
  add_index "user_channels", ["channel_id"], name: "subscribed", using: :btree
  add_index "user_channels", ["user_id", "channel_id"], name: "idx_subscription_by_channel", using: :btree
  add_index "user_channels", ["user_id"], name: "idx_subscription", using: :btree

  create_table "user_items", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.boolean  "viewed"
    t.datetime "created_at"
    t.integer  "channel_id", limit: 8
    t.integer  "stopped_at", limit: 8
    t.datetime "updated_at"
  end

  add_index "user_items", ["channel_id", "user_id"], name: "idx_listened_by_channel", using: :btree
  add_index "user_items", ["channel_id", "user_id"], name: "listened2", using: :btree
  add_index "user_items", ["item_id", "user_id"], name: "listened", using: :btree
  add_index "user_items", ["item_id", "viewed", "user_id"], name: "idx_listened", using: :btree
  add_index "user_items", ["item_id"], name: "idx_episode_listened", using: :btree
  add_index "user_items", ["user_id", "viewed"], name: "index4", using: :btree

  create_table "users", id: :bigserial, force: :cascade do |t|
    t.string   "name",                               limit: 255
    t.string   "email",                              limit: 255, null: false
    t.string   "password",                           limit: 100
    t.string   "locale",                             limit: 255
    t.datetime "created_at"
    t.datetime "last_visited_at"
    t.string   "provider",                           limit: 100
    t.string   "provider_id",                        limit: 50
    t.string   "remember_token",                     limit: 100
    t.string   "api_token",                          limit: 100
    t.boolean  "welcome_mail"
    t.datetime "agree_with_the_terms_and_policy_at"
    t.string   "agree_with_the_terms_and_policy_in", limit: 255
  end

  add_index "users", ["api_token"], name: "idx_user_by_token", using: :btree
  add_index "users", ["api_token"], name: "idx_user_token", unique: true, using: :btree
  add_index "users", ["api_token"], name: "users_api_token_key", unique: true, using: :btree
  add_index "users", ["email"], name: "idx_user_by_email", using: :btree
  add_index "users", ["email"], name: "idx_user_email", unique: true, using: :btree
  add_index "users", ["email"], name: "users_email_key", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "users_remember_token_key", unique: true, using: :btree

  create_table "visits", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid     "visitor_id"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.integer  "screen_height"
    t.integer  "screen_width"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

end
