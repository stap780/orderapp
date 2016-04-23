class AddWorkStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :work_status, :string
  end
end
