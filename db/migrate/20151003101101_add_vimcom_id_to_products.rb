class AddVimcomIdToProducts < ActiveRecord::Migration
  def change
  add_column :products, :vimcom_id, :integer
  end
end
