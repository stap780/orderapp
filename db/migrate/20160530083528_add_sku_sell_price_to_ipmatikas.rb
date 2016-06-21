class AddSkuSellPriceToIpmatikas < ActiveRecord::Migration
  def change
  	add_column :ipmatikas, :sku, :string
  	add_column :ipmatikas, :sell_price, :decimal,    precision: 8, scale: 2
  end
end
