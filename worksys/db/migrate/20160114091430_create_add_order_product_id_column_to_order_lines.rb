class CreateAddOrderProductIdColumnToOrderLines < ActiveRecord::Migration
  def change
    create_table :add_order_product_id_column_to_order_lines do |t|

      t.timestamps null: false
    end
  end
end
