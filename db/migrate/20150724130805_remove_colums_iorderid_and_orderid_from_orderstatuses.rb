class RemoveColumsIorderidAndOrderidFromOrderstatuses < ActiveRecord::Migration
  def change
  remove_column :orderstatuses, :iorder_id, :integer
  remove_column :orderstatuses, :order_id, :integer
  end
end
