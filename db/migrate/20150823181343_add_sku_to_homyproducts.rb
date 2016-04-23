class AddSkuToHomyproducts < ActiveRecord::Migration
  def change
  	add_column :homyproducts, :sku, :string
  	add_index :homyproducts, :sku
  end
end
