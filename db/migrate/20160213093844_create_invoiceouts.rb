class CreateInvoiceouts < ActiveRecord::Migration
  def change
    create_table :invoiceouts do |t|
      t.integer :number
      t.datetime :date
      t.integer :company_id
      t.integer :invoice_list_id
      t.decimal :total_price,        precision: 8, scale: 2
      t.decimal :nds,        precision: 8, scale: 2
      t.string :payment

      t.timestamps null: false
    end
    add_index :invoiceouts, :number
  end
end
