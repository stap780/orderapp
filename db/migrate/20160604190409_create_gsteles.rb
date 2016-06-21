class CreateGsteles < ActiveRecord::Migration
  def change
    create_table :gsteles do |t|
      t.string :sku
      t.string :title
      t.integer :quantity
      t.string :valute
      t.decimal :cost_price,      precision: 8, scale: 2
      t.decimal :price,      precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :gsteles, :title
  end
end
