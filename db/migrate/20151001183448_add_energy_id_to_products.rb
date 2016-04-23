class AddEnergyIdToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :energy_id, :integer
  end
end
