class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.integer :invoice_list_id
      t.integer :purchase_list_id
      t.integer :quantity
      t.decimal :price,      precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
