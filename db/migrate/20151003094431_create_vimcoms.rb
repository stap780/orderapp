class CreateVimcoms < ActiveRecord::Migration
  def change
    create_table :vimcoms do |t|
      t.string :title
      t.integer :quantity_all
      t.integer :quantity_free

      t.timestamps null: false
    end
    
    add_index :vimcoms, :title
  end
end
