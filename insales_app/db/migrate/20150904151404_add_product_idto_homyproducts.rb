class AddProductIdtoHomyproducts < ActiveRecord::Migration
  def change
    add_column :homyproducts, :product_id, :integer
    
  end
  
end
