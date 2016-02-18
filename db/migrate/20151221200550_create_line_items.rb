class CreateLineItems < ActiveRecord::Migration
  def up
    create_table :line_items do |t|
	t.integer :iorder_id
    t.integer :product_id
    t.integer :quantity
    t.timestamps null: false
    end
    drop_table :iorders_products
  end
end
