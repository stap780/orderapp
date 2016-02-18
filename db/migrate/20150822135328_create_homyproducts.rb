class CreateHomyproducts < ActiveRecord::Migration
  def change
    create_table :homyproducts do |t|
      t.string  :artikul
      t.string  :title
      t.decimal :price, precision: 8, scale: 2
      t.string  :valuta
      t.integer :quantity_all_res
      t.integer :quantity_all_free
      t.integer :quantity_main_res
      t.integer :quantity_main_free
      t.integer :quantity_tul_res
      t.integer :quantity_tul_free
      t.integer :quantity_transit_all
      t.integer :quantity_transit_free

      t.timestamps null: false
    end
    add_index :homyproducts, :artikul
    add_index :homyproducts, :quantity_all_free
    add_index :homyproducts, :title
  end
end
