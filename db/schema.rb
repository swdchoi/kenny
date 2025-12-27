# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_12_26_114431) do
  create_table "clients", force: :cascade do |t|
    t.string "email"
    t.string "company_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "title"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.float "total_amount"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_contracts_on_client_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "payment_term_id", null: false
    t.integer "status"
    t.date "issue_date"
    t.date "due_date"
    t.date "paid_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_term_id"], name: "index_invoices_on_payment_term_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "status", default: "pending"
    t.integer "contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "completed_date"
    t.text "description"
    t.index ["contract_id"], name: "index_milestones_on_contract_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.integer "user_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_notes_on_invoice_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "payment_terms", force: :cascade do |t|
    t.integer "contract_id", null: false
    t.string "description"
    t.float "percentage"
    t.float "amount"
    t.date "target_date"
    t.integer "status"
    t.date "completed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "milestone_id"
    t.index ["contract_id"], name: "index_payment_terms_on_contract_id"
    t.index ["milestone_id"], name: "index_payment_terms_on_milestone_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contracts", "clients"
  add_foreign_key "invoices", "payment_terms"
  add_foreign_key "milestones", "contracts"
  add_foreign_key "notes", "invoices"
  add_foreign_key "notes", "users"
  add_foreign_key "payment_terms", "contracts"
  add_foreign_key "payment_terms", "milestones"
end
