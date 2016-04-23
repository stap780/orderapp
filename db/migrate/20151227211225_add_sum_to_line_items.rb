class AddSumToLineItems < ActiveRecord::Migration
  def change
  add_column :line_items, :sum, :decimal,      precision: 8, scale: 2
  end
end
