class CreateEnergies < ActiveRecord::Migration
  def change
    create_table :energies do |t|
      t.string :sku
      t.string :title
      t.integer :quantity
      t.decimal :cost_price, precision: 8, scale: 2
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :energies, :sku
    add_index :energies, :title
  end
end
