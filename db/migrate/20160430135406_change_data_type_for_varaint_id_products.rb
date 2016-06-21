class ChangeDataTypeForVaraintIdProducts < ActiveRecord::Migration
  def change
  change_column :products, :variant_id, :integer, :limit => 8 
  end
end
