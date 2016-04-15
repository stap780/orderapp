class AddColumnPriceCostPriceToIpmatikas < ActiveRecord::Migration
  def change
  add_column :ipmatikas, :cost_price, :decimal,      precision: 8, scale: 2
  add_column :ipmatikas, :price, :decimal,      precision: 8, scale: 2
  end
end
