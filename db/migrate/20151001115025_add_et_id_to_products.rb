class AddEtIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :et_id, :integer
  end
end
