class CreateImls < ActiveRecord::Migration
  def change
    create_table :imls do |t|
      t.integer :number
      t.string :state
      t.string :status
      t.datetime :statusdate
      t.integer :barcode

      t.timestamps null: false
    end
    add_index :imls, :number
    add_index :imls, :status
  end
end
