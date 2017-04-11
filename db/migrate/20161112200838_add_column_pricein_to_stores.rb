class AddColumnPriceinToStores < ActiveRecord::Migration
  def change
  add_column :stores, :pricein, :decimal,      precision: 8, scale: 2
  end
end
