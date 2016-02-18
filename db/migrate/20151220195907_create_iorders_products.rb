class CreateIordersProducts < ActiveRecord::Migration
  def change
    create_table :iorders_products, id: false do |t|
    t.integer :iorder_id
    t.integer :product_id
    end
  end
end
