class CreateCouriers < ActiveRecord::Migration
  def change
    create_table :couriers do |t|
      t.integer :number
      t.datetime :date
      t.string :state

      t.timestamps null: false
    end
  end
end
