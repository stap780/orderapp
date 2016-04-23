# -*- encoding : utf-8 -*-
class CreateOrderstatuses < ActiveRecord::Migration
  def change
    create_table :orderstatuses do |t|
      t.integer :order_id
      t.string  :title
      t.timestamps null: false
    end
    add_index :orderstatuses, :order_id
  end
end
