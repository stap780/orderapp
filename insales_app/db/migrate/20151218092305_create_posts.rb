class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :number
      t.string :postnumber
      t.datetime :pickupdate
      t.string :state

      t.timestamps null: false
    end
    add_index :posts, :postnumber
  end
end
