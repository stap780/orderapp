class CreatePurchaseInvoices < ActiveRecord::Migration
  def change
    create_table :purchase_invoices do |t|
      t.string :number
      t.datetime :date
      t.integer :company_id
      t.decimal :total_price,      precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
