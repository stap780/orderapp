class AddColumnDiscountToEmags < ActiveRecord::Migration
  def change
  add_column :emags, :discount, :integer
  end
end
