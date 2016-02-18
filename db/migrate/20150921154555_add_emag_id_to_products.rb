class AddEmagIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :emag_id, :integer
  end
end
