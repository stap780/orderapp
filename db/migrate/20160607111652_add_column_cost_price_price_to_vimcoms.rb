class AddColumnCostPricePriceToVimcoms < ActiveRecord::Migration
  def change
 	add_column :vimcoms, :cost_price, :decimal,    precision: 8, scale: 2
  	add_column :vimcoms, :price, :decimal,    precision: 8, scale: 2

  end
end
