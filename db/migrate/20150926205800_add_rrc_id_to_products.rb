class AddRrcIdToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :rrc_id, :integer
  end
end
