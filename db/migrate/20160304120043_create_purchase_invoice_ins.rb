class CreatePurchaseInvoiceIns < ActiveRecord::Migration
  def change
    create_table :purchase_invoice_ins do |t|
      t.string :number
      t.datetime :data
      t.integer :purchase_list_id

      t.timestamps null: false
    end
    add_index :purchase_invoice_ins, :number
  end
end
