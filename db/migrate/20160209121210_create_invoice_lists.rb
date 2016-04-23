class CreateInvoiceLists < ActiveRecord::Migration
  def change
    create_table :invoice_lists do |t|
      t.integer :number
      t.datetime :date
      t.string :status
      t.decimal :total_price, precision: 8, scale: 2
      t.integer :client_id
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
