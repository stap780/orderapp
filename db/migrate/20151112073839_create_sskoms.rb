class CreateSskoms < ActiveRecord::Migration
  def change
    create_table :sskoms do |t|
      t.string :title
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :sskoms, :title
  end
end
