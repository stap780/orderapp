class CreateIordersOrderstatuses < ActiveRecord::Migration
  def change
    create_table :iorders_orderstatuses, id: false  do |t|
      t.integer :iorder_id
      t.integer :orderstatus_id
    end
  end
end
