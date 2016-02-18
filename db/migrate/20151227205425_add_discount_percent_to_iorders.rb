class AddDiscountPercentToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :discount_percent, :decimal,      precision: 8, scale: 2
  add_column :iorders, :total_price, :decimal,      precision: 8, scale: 2
  end
end
