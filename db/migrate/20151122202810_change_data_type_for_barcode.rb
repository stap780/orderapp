class ChangeDataTypeForBarcode < ActiveRecord::Migration
  def change
  change_column :imls, :barcode, :integer, :limit => 8
  end
end
