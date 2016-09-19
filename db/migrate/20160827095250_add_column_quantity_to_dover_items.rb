class AddColumnQuantityToDoverItems < ActiveRecord::Migration
  def change
    add_column :dover_items, :quantity, :integer
  end
end
