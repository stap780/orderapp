class AddSskomIdToProducts < ActiveRecord::Migration
  def change
  add_column :products, :sskom_id, :integer
  end
end
