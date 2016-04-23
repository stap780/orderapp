class AddOrderProductIdColumnToOrderLines < ActiveRecord::Migration
  def change
  add_column :order_lines, :order_id, :integer
    add_column :order_lines, :product_id, :integer
  end
end
