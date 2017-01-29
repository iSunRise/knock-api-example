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

ActiveRecord::Schema.define(version: 20170129162358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "position"
    t.string   "email",                            null: false
    t.string   "password_digest",                  null: false
    t.string   "roles",               default: [],              array: true
    t.string   "photo"
    t.integer  "software_company_id",              null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["software_company_id"], name: "index_accounts_on_software_company_id", using: :btree
  end

  create_table "software_companies", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "url_alias"
    t.string   "website"
    t.text     "about"
    t.string   "logo"
    t.string   "background_photo"
    t.integer  "number_of_employees"
    t.text     "contacts"
    t.string   "vat"
    t.boolean  "deleted",             default: false
    t.boolean  "listed",              default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["url_alias"], name: "index_software_companies_on_url_alias", using: :btree
  end

  add_foreign_key "accounts", "software_companies"
end
