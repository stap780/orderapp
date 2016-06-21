class ChangeDataTypeForVariaintInidVariants < ActiveRecord::Migration
  def change
  change_column :variants, :variant_inid, :integer, :limit => 20 
  end
end
