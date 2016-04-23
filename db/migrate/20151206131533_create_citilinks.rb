class CreateCitilinks < ActiveRecord::Migration
  def change
    create_table :citilinks do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.decimal :price1, precision: 8, scale: 2
      t.decimal :priceusd, precision: 8, scale: 2
      t.string :q1
      t.string :q2
      t.string :q3
      t.string :q4
      t.string :q5

      t.timestamps null: false
    end
   
    add_index :citilinks, :title
  end
end
