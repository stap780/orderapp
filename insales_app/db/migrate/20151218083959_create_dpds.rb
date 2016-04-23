class CreateDpds < ActiveRecord::Migration
  def change
    create_table :dpds do |t|
      t.integer :numer
      t.string :dpdnumber
      t.datetime :pickupdate
      t.datetime :plandeliverytime
      t.string :state

      t.timestamps null: false
    end
    add_index :dpds, :numer
    add_index :dpds, :dpdnumber
  end
end
