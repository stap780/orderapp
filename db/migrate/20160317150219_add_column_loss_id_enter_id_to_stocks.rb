class AddColumnLossIdEnterIdToStocks < ActiveRecord::Migration
  def change
  add_column :stocks, :loss_id, :integer
  add_column :stocks, :enter_id, :integer
  end
end
