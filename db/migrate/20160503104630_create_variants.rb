class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :product_id
      t.integer :variant_inid
      t.string :sku
      t.decimal :cost_price,      precision: 8, scale: 2
      t.decimal :price,      precision: 8, scale: 2
      t.decimal :old_price,      precision: 8, scale: 2
      t.integer :quantity
      t.decimal :weight,      precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
