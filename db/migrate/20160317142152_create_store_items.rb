class CreateStoreItems < ActiveRecord::Migration
  def change
    create_table :store_items do |t|
      t.integer :loss_id
      t.integer :enter_id
      t.integer :product_id
      t.integer :quantity
      t.string :title
      t.decimal :price,      precision: 8, scale: 2
      t.decimal :sum,      precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
