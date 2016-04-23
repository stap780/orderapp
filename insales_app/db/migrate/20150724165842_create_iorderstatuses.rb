class CreateIorderstatuses < ActiveRecord::Migration
  def up
    create_table :iorderstatuses do |t|
      t.integer :iorder_id
      t.integer :orderstatus_id
      t.timestamps null: false
    end
    drop_table :iorders_orderstatuses
  end
end
