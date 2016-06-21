class AddColumnSupplierNameToProductOptions < ActiveRecord::Migration
  def change
  add_column :product_options, :supplier_name, :string
  end
end
