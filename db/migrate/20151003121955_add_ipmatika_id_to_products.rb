class AddIpmatikaIdToProducts < ActiveRecord::Migration
  def change
  add_column :products, :ipmatika_id, :integer
  end
end
