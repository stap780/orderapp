class CreateIpmatikas < ActiveRecord::Migration
  def change
    create_table :ipmatikas do |t|
      t.string :title
      t.integer :quantity_all
      t.integer :quantity_res
      t.integer :quantity_free

      t.timestamps null: false
    end
    add_index :ipmatikas, :title
  end
end
