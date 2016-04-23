class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.text :title
      t.integer :quantity
      t.decimal :price
      t.decimal :sum

      t.timestamps null: false
    end
  end
end
