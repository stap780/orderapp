class RenameColumnProductIdInStores < ActiveRecord::Migration
  def change
    	rename_column :stores, :product_id, :title
    	change_column:stores, :title, :string
  end
end
