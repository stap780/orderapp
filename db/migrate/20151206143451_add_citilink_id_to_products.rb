class AddCitilinkIdToProducts < ActiveRecord::Migration
  def change
  add_column :products, :citilink_id, :integer
  end
end
