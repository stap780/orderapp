class CreateProductOptions < ActiveRecord::Migration
  def change
    create_table :product_options do |t|
      t.integer :opt_value_inid
      t.integer :opt_name_inid
      t.string :title

      t.timestamps null: false
    end
  end
end
