class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :webid
      t.string :title
      t.string :url

      t.timestamps null: false
    end
  end
end
