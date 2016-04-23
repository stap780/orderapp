class AddAngelIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :angel_id, :integer
  end
end
