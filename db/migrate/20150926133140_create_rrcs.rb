class CreateRrcs < ActiveRecord::Migration
  def change
    create_table :rrcs do |t|
      t.string :sku
      t.string :title
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
