class AddQuantityToCitilinks < ActiveRecord::Migration
  def change
  add_column :citilinks, :quantity, :integer
  end
end
