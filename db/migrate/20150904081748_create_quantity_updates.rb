class CreateQuantityUpdates < ActiveRecord::Migration
  def up
    create_table :quantity_updates do |t|
      t.integer :homyproduct_id
      t.integer :product_id
      t.timestamps null: false
    end
    drop_table :homyproducts_products
  end
end
