class CreateIcrs < ActiveRecord::Migration
  def change
    create_table :icrs do |t|
      t.integer :icr_id
      t.string :title
      t.decimal :price_usd, precision: 8, scale: 2
      t.decimal :price_rub, precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :icrs, :icr_id
    add_index :icrs, :title
  end
end
