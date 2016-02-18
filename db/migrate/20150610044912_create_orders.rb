# -*- encoding : utf-8 -*-
class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :order_status
      t.string :order_payment_status

      t.timestamps null: false
    end
  end
end
