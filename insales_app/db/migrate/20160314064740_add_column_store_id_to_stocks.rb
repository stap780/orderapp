class AddColumnStoreIdToStocks < ActiveRecord::Migration
  def change
      add_column :stocks, :store_id, :integer
  end
end
