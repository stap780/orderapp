class AddTreolanIdToProducts < ActiveRecord::Migration
  def change
  add_column :products, :treolan_id, :integer
  end
end
