class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :number
      t.datetime :date,    null: false
      t.integer :client_id
      t.string :invstatus
      t.decimal :discount,       precision: 8, scale: 2
      t.decimal :total_price,       precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :invoices, :number
  end
end
