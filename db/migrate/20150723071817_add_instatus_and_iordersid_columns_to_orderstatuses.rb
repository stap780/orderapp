class AddInstatusAndIordersidColumnsToOrderstatuses < ActiveRecord::Migration
  def change
  	add_column :orderstatuses, :number, :integer
  	add_column :orderstatuses, :instatus, :string
  	add_column :orderstatuses, :iorder_id, :integer
  
  	add_index :orderstatuses, :iorder_id
  	add_index :orderstatuses, :number
  	end
end
