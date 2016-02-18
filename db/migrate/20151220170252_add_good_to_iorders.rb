class AddGoodToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :variantid, :integer
  add_column :iorders, :quantity, :integer
  add_column :iorders, :price, :decimal, precision: 8, scale: 2
  add_column :iorders, :deliveryprice, :decimal, precision: 8, scale: 2
  end
end
