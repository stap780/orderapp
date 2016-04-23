class CreateEnters < ActiveRecord::Migration
  def change
    create_table :enters do |t|
      t.integer :number
      t.datetime :date
      t.string :description
      t.decimal :total,      precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :enters, :number
  end
end
