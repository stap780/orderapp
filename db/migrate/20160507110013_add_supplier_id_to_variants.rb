class AddSupplierIdToVariants < ActiveRecord::Migration
  def change
  add_column :variants, :supplier_id, :integer
  end
end
