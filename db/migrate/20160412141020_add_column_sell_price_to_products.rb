class AddColumnSellPriceToProducts < ActiveRecord::Migration
  def change
  add_column :products, :sell_price, :decimal,      precision: 8, scale: 2
  end
end
