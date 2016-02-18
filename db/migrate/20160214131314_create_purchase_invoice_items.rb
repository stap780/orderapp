class CreatePurchaseInvoiceItems < ActiveRecord::Migration
  def change
    create_table :purchase_invoice_items do |t|
    t.integer  "purchase_invoice_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "title"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "sum",        precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
