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

ActiveRecord::Schema.define(version: 20160729202119) do

  create_table "accounts", force: :cascade do |t|
    t.text     "insales_subdomain", null: false
    t.text     "password",          null: false
    t.integer  "insales_id",        null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "accounts", ["insales_subdomain"], name: "index_accounts_on_insales_subdomain", unique: true

  create_table "angels", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.integer  "quantity"
    t.string   "status"
    t.string   "valuta"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "cost_price", precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "angels", ["sku"], name: "index_angels_on_sku"
  add_index "angels", ["title"], name: "index_angels_on_title"

  create_table "cases", force: :cascade do |t|
    t.integer  "number"
    t.integer  "client_id"
    t.integer  "iorder_id"
    t.string   "status"
    t.string   "service"
    t.string   "description"
    t.boolean  "iorder_check"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "citilinks", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "price1",     precision: 8, scale: 2
    t.decimal  "priceusd",   precision: 8, scale: 2
    t.string   "q1"
    t.string   "q2"
    t.string   "q3"
    t.string   "q4"
    t.string   "q5"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "quantity"
  end

  add_index "citilinks", ["title"], name: "index_citilinks_on_title"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "middlename"
    t.string   "surname"
    t.string   "phone"
    t.string   "email"
    t.integer  "zip"
    t.string   "state"
    t.string   "city"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "title"
    t.string   "fulltitle"
    t.string   "uraddress"
    t.string   "factaddress"
    t.integer  "inn",         limit: 8
    t.integer  "kpp",         limit: 8
    t.integer  "ogrn",        limit: 8
    t.integer  "okpo",        limit: 8
    t.integer  "bik",         limit: 8
    t.string   "banktitle"
    t.integer  "bankaccount", limit: 20
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contragents", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "couriers", force: :cascade do |t|
    t.integer  "number"
    t.datetime "date"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "dpds", force: :cascade do |t|
    t.integer  "numer"
    t.string   "dpdnumber"
    t.datetime "pickupdate"
    t.datetime "plandeliverytime"
    t.string   "state"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "dpds", ["dpdnumber"], name: "index_dpds_on_dpdnumber"
  add_index "dpds", ["numer"], name: "index_dpds_on_numer"

  create_table "emags", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.integer  "quantity"
    t.decimal  "cost_price", precision: 8, scale: 2
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "discount"
  end

  add_index "emags", ["sku"], name: "index_emags_on_sku"
  add_index "emags", ["title"], name: "index_emags_on_title"

  create_table "energies", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.integer  "quantity"
    t.decimal  "cost_price",        precision: 8, scale: 2
    t.decimal  "price",             precision: 8, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "short_description"
    t.string   "description"
    t.string   "image_url"
  end

  add_index "energies", ["sku"], name: "index_energies_on_sku"
  add_index "energies", ["title"], name: "index_energies_on_title"

  create_table "enters", force: :cascade do |t|
    t.integer  "number"
    t.datetime "date"
    t.string   "description"
    t.decimal  "total",       precision: 8, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "enters", ["number"], name: "index_enters_on_number"

  create_table "ets", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.integer  "quantity"
    t.decimal  "cost_price", precision: 8, scale: 2
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "ets", ["sku"], name: "index_ets_on_sku"
  add_index "ets", ["title"], name: "index_ets_on_title"

  create_table "gsteles", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.integer  "quantity"
    t.string   "valute"
    t.decimal  "cost_price", precision: 8, scale: 2
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "gsteles", ["title"], name: "index_gsteles_on_title"

  create_table "homyproducts", force: :cascade do |t|
    t.integer  "artikul"
    t.string   "title"
    t.decimal  "price",                 precision: 8, scale: 2
    t.string   "valuta"
    t.integer  "quantity_all_res"
    t.integer  "quantity_all_free"
    t.integer  "quantity_main_res"
    t.integer  "quantity_main_free"
    t.integer  "quantity_tul_res"
    t.integer  "quantity_tul_free"
    t.integer  "quantity_transit_all"
    t.integer  "quantity_transit_free"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "sku"
    t.integer  "product_id"
    t.decimal  "sell_price",            precision: 8, scale: 2
    t.decimal  "min_price",             precision: 8, scale: 2
  end

  add_index "homyproducts", ["artikul"], name: "index_homyproducts_on_artikul"
  add_index "homyproducts", ["quantity_all_free"], name: "index_homyproducts_on_quantity_all_free"
  add_index "homyproducts", ["sku"], name: "index_homyproducts_on_sku"
  add_index "homyproducts", ["title"], name: "index_homyproducts_on_title"

  create_table "icrs", force: :cascade do |t|
    t.integer  "icr_id"
    t.string   "title"
    t.decimal  "price_usd",  precision: 8, scale: 2
    t.decimal  "price_rub",  precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "icrs", ["icr_id"], name: "index_icrs_on_icr_id"
  add_index "icrs", ["title"], name: "index_icrs_on_title"

  create_table "imls", force: :cascade do |t|
    t.integer  "number"
    t.string   "state"
    t.string   "status"
    t.datetime "statusdate"
    t.integer  "barcode",    limit: 8
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "statenum"
    t.integer  "statusnum"
  end

  add_index "imls", ["number"], name: "index_imls_on_number"
  add_index "imls", ["status"], name: "index_imls_on_status"

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "title"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "sum",        precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "invoice_list_items", force: :cascade do |t|
    t.integer  "invoice_list_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "title"
    t.decimal  "price",           precision: 8, scale: 2
    t.decimal  "sum",             precision: 8, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "invoice_lists", force: :cascade do |t|
    t.integer  "number"
    t.datetime "date"
    t.string   "status"
    t.decimal  "total_price",      precision: 8, scale: 2
    t.integer  "client_id"
    t.integer  "company_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "invoice_id"
    t.decimal  "discount",         precision: 8, scale: 2
    t.integer  "companytwo"
    t.boolean  "invoiceout_check"
  end

  create_table "invoiceouts", force: :cascade do |t|
    t.integer  "number"
    t.datetime "date"
    t.integer  "company_id"
    t.integer  "invoice_list_id"
    t.decimal  "total_price",     precision: 8, scale: 2
    t.decimal  "nds",             precision: 8, scale: 2
    t.string   "payment"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "invoiceouts", ["number"], name: "index_invoiceouts_on_number"

  create_table "invoices", force: :cascade do |t|
    t.integer  "number"
    t.datetime "date",                                       null: false
    t.integer  "client_id"
    t.string   "invstatus"
    t.decimal  "discount",           precision: 8, scale: 2
    t.decimal  "total_price",        precision: 8, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "company_id"
    t.integer  "companytwo"
    t.boolean  "invoice_list_check"
    t.integer  "iorder_id"
  end

  add_index "invoices", ["number"], name: "index_invoices_on_number"

  create_table "iorders", force: :cascade do |t|
    t.integer  "inid"
    t.integer  "number"
    t.string   "instatus"
    t.string   "financial"
    t.string   "payment"
    t.string   "clientname"
    t.string   "delivery"
    t.string   "phone"
    t.string   "email"
    t.decimal  "total",             precision: 8, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "client_middlename"
    t.string   "client_surname"
    t.integer  "shipping_zip"
    t.string   "shipping_city"
    t.string   "shipping_address"
    t.integer  "status_id"
    t.integer  "mycourier_id"
    t.integer  "iml_id"
    t.integer  "dpd_id"
    t.integer  "post_id"
    t.integer  "courier_id"
    t.integer  "variantid"
    t.integer  "quantity"
    t.decimal  "price",             precision: 8, scale: 2
    t.decimal  "deliveryprice",     precision: 8, scale: 2
    t.decimal  "discount_percent",  precision: 8, scale: 2
    t.decimal  "total_price",       precision: 8, scale: 2
    t.integer  "client_id"
    t.boolean  "invoice_check"
    t.integer  "invoice_id"
  end

  add_index "iorders", ["financial"], name: "index_iorders_on_financial"
  add_index "iorders", ["instatus"], name: "index_iorders_on_instatus"
  add_index "iorders", ["number"], name: "index_iorders_on_number"

  create_table "iorderstatuses", force: :cascade do |t|
    t.integer  "iorder_id"
    t.integer  "orderstatus_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ipmatikas", force: :cascade do |t|
    t.string   "title"
    t.integer  "quantity_all"
    t.integer  "quantity_res"
    t.integer  "quantity_free"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.decimal  "cost_price",    precision: 8, scale: 2
    t.decimal  "price",         precision: 8, scale: 2
    t.string   "sku"
    t.decimal  "sell_price",    precision: 8, scale: 2
  end

  add_index "ipmatikas", ["title"], name: "index_ipmatikas_on_title"

  create_table "line_items", force: :cascade do |t|
    t.integer  "iorder_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "title"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "sum",        precision: 8, scale: 2
    t.integer  "invoice_id"
  end

  create_table "losses", force: :cascade do |t|
    t.integer  "number"
    t.datetime "date"
    t.string   "description"
    t.decimal  "total",       precision: 8, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "losses", ["number"], name: "index_losses_on_number"

  create_table "mycouriers", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "number"
  end

  add_index "mycouriers", ["title"], name: "index_mycouriers_on_title"

  create_table "orders", force: :cascade do |t|
    t.string   "order_number"
    t.string   "order_payment_status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "work_status"
    t.integer  "orderstatus_id"
  end

  create_table "orderstatuses", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "number"
    t.string   "instatus"
  end

  add_index "orderstatuses", ["number"], name: "index_orderstatuses_on_number"

  create_table "posts", force: :cascade do |t|
    t.integer  "number"
    t.string   "postnumber"
    t.datetime "pickupdate"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["postnumber"], name: "index_posts_on_postnumber"

  create_table "product_options", force: :cascade do |t|
    t.integer  "opt_value_inid"
    t.integer  "opt_name_inid"
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "variant_id"
    t.string   "supplier_name"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "inid"
    t.string   "sku"
    t.string   "title"
    t.text     "short_description"
    t.integer  "quantity"
    t.decimal  "cost_price",                  precision: 8, scale: 2
    t.decimal  "price",                       precision: 8, scale: 2
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "category_id"
    t.integer  "homyproduct_id"
    t.integer  "variant_id",        limit: 8
    t.integer  "emag_id"
    t.integer  "rrc_id"
    t.integer  "angel_id"
    t.integer  "et_id"
    t.integer  "energy_id"
    t.integer  "vimcom_id"
    t.integer  "ipmatika_id"
    t.integer  "sskom_id"
    t.integer  "treolan_id"
    t.integer  "citilink_id"
    t.integer  "store_id"
    t.decimal  "sell_price",                  precision: 8, scale: 2
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["inid"], name: "index_products_on_inid"
  add_index "products", ["sku"], name: "index_products_on_sku"
  add_index "products", ["title"], name: "index_products_on_title"

  create_table "purchase_invoice_ins", force: :cascade do |t|
    t.string   "number"
    t.datetime "data"
    t.integer  "purchase_list_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "purchase_invoice_ins", ["number"], name: "index_purchase_invoice_ins_on_number"

  create_table "purchase_invoice_items", force: :cascade do |t|
    t.integer  "purchase_invoice_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "title"
    t.decimal  "price",               precision: 8, scale: 2
    t.decimal  "sum",                 precision: 8, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "purchase_invoices", force: :cascade do |t|
    t.string   "number"
    t.datetime "date"
    t.integer  "company_id"
    t.decimal  "total_price",         precision: 8, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "purchase_list_check"
    t.string   "status"
  end

  create_table "purchase_list_items", force: :cascade do |t|
    t.integer  "purchase_list_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "title"
    t.decimal  "price",            precision: 8, scale: 2
    t.decimal  "sum",              precision: 8, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "purchase_lists", force: :cascade do |t|
    t.string   "number"
    t.datetime "date"
    t.integer  "company_id"
    t.decimal  "total_price",              precision: 8, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "purchase_invoicein_check"
    t.string   "status"
    t.integer  "purchase_invoice_id"
  end

  add_index "purchase_lists", ["number"], name: "index_purchase_lists_on_number"

  create_table "quantity_updates", force: :cascade do |t|
    t.integer  "homyproduct_id"
    t.integer  "product_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "rrcs", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.integer  "quantity"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.decimal  "cost_price", precision: 8, scale: 2
    t.decimal  "sell_price", precision: 8, scale: 2
    t.decimal  "price",      precision: 8, scale: 2
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sskoms", force: :cascade do |t|
    t.string   "title"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sskoms", ["title"], name: "index_sskoms_on_title"

  create_table "statuses", force: :cascade do |t|
    t.integer  "number"
    t.string   "title"
    t.string   "instatus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "statuses", ["title"], name: "index_statuses_on_title"

  create_table "stocks", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "invoice_list_id"
    t.integer  "purchase_list_id"
    t.integer  "quantity"
    t.decimal  "price",            precision: 8, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "store_id"
    t.integer  "loss_id"
    t.integer  "enter_id"
  end

  create_table "store_items", force: :cascade do |t|
    t.integer  "loss_id"
    t.integer  "enter_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "title"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "sum",        precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "title"
    t.integer  "quantity"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "treolans", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.string   "quantity"
    t.string   "transit"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "treolans", ["sku"], name: "index_treolans_on_sku"
  add_index "treolans", ["title"], name: "index_treolans_on_title"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "login"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "variants", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "variant_inid",      limit: 20
    t.string   "sku"
    t.decimal  "cost_price",                   precision: 8, scale: 2
    t.decimal  "price",                        precision: 8, scale: 2
    t.decimal  "old_price",                    precision: 8, scale: 2
    t.integer  "quantity"
    t.decimal  "weight",                       precision: 8, scale: 2
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "product_option_id"
    t.integer  "supplier_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vimcoms", force: :cascade do |t|
    t.string   "title"
    t.integer  "quantity_all"
    t.integer  "quantity_free"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.decimal  "cost_price",    precision: 8, scale: 2
    t.decimal  "price",         precision: 8, scale: 2
  end

  add_index "vimcoms", ["title"], name: "index_vimcoms_on_title"

end
