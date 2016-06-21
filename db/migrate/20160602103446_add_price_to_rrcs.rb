class AddPriceToRrcs < ActiveRecord::Migration
  def change
  	add_column :rrcs, :cost_price, :decimal,    precision: 8, scale: 2
  	add_column :rrcs, :sell_price, :decimal,    precision: 8, scale: 2
  	add_column :rrcs, :price, :decimal,    precision: 8, scale: 2
  end
end
