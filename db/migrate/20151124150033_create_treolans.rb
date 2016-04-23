class CreateTreolans < ActiveRecord::Migration
  def change
    create_table :treolans do |t|
      t.string :sku
      t.string :title
      t.integer :quantity
      t.integer :transit
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :treolans, :title
    add_index :treolans, :sku
  end
end
