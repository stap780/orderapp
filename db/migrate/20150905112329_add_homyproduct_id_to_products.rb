class AddHomyproductIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :homyproduct_id, :integer
  end
end
