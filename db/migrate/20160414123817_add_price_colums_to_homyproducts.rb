class AddPriceColumsToHomyproducts < ActiveRecord::Migration
  def change
  add_column :homyproducts, :sell_price, :decimal,      precision: 8, scale: 2
  add_column :homyproducts, :min_price, :decimal,      precision: 8, scale: 2
  end
end
