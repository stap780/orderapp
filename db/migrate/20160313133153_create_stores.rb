class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.integer :product_id
      t.integer :quantity
      t.decimal :price,      precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
