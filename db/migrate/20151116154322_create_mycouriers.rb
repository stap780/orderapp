class CreateMycouriers < ActiveRecord::Migration
  def change
    create_table :mycouriers do |t|
      t.string :title

      t.timestamps null: false
    end
    add_index :mycouriers, :title
  end
end
