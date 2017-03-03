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

ActiveRecord::Schema.define(version: 20170303152248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "position"
    t.string   "email",                                   null: false
    t.string   "password_digest",                         null: false
    t.string   "roles",                   default: [],                 array: true
    t.string   "photo"
    t.integer  "software_company_id",                     null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "phone_number"
    t.boolean  "two_factor_auth_enabled", default: false
    t.index ["email"], name: "index_accounts_on_email", unique: true, using: :btree
    t.index ["software_company_id"], name: "index_accounts_on_software_company_id", using: :btree
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "offices", force: :cascade do |t|
    t.string   "software_company_id"
    t.integer  "priority"
    t.string   "country",                          null: false
    t.string   "city",                             null: false
    t.string   "details"
    t.string   "phones",              default: [],              array: true
    t.string   "emails",              default: [],              array: true
    t.jsonb    "working_times",       default: {}
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["priority"], name: "index_offices_on_priority", using: :btree
    t.index ["software_company_id"], name: "index_offices_on_software_company_id", using: :btree
  end

  create_table "phone_verifications", force: :cascade do |t|
    t.string   "phone_number",                 null: false
    t.string   "pin_token"
    t.integer  "attempts",     default: 0
    t.boolean  "matched",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["phone_number"], name: "index_phone_verifications_on_phone_number", using: :btree
  end

  create_table "software_companies", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.string   "url_alias"
    t.string   "website"
    t.text     "about"
    t.string   "logo"
    t.string   "background_photo"
    t.integer  "number_of_employees"
    t.text     "contacts"
    t.string   "vat"
    t.boolean  "deleted",              default: false
    t.boolean  "listed",               default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.date     "foundation_date"
    t.integer  "average_hourly_rate"
    t.integer  "minimum_project_size"
    t.index ["url_alias"], name: "index_software_companies_on_url_alias", using: :btree
  end

  create_table "software_company_specialties", force: :cascade do |t|
    t.integer  "software_company_id", null: false
    t.integer  "specialty_id",        null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["software_company_id", "specialty_id"], name: "software_company_specialties_index", unique: true, using: :btree
  end

  create_table "software_company_technologies", force: :cascade do |t|
    t.integer  "software_company_id", null: false
    t.integer  "technology_id",       null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["software_company_id", "technology_id"], name: "software_company_technologies_index", unique: true, using: :btree
  end

  create_table "specialties", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "token",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_specialties_on_token", unique: true, using: :btree
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "token",      null: false
    t.index ["token"], name: "index_technologies_on_token", unique: true, using: :btree
  end

  add_foreign_key "accounts", "software_companies"
end
