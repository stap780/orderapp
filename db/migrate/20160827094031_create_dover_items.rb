class CreateDoverItems < ActiveRecord::Migration
  def change
    create_table :dover_items do |t|
      t.integer :dover_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
