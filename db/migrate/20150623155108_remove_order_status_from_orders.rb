class RemoveOrderStatusFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :order_status, :string
    add_column :orders, :orderstatus_id, :integer
  end
end
