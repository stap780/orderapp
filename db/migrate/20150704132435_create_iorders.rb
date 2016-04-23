class CreateIorders < ActiveRecord::Migration
  def change
    create_table :iorders do |t|
      t.integer :inid
      t.integer :number
      t.string :status
      t.string :financial
      t.string :payment
      t.string :client
      t.string :delivery
      t.string :phone
      t.string :email
      t.decimal :total, precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :iorders, :number
    add_index :iorders, :status
    add_index :iorders, :financial
  end
end
