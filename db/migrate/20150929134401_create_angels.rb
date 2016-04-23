class CreateAngels < ActiveRecord::Migration
  def change
    create_table :angels do |t|
      t.string :sku
      t.string :title
      t.integer :quantity
      t.string :status
      t.string :valuta
      t.decimal :price, precision: 8, scale: 2
      t.decimal :cost_price, precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :angels, :sku
    add_index :angels, :title
  end
end
