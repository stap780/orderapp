class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.integer :number
      t.integer :client_id
      t.integer :iorder_id
      t.string :status
      t.string :service
      t.string :description
      t.boolean :iorder_check

      t.timestamps null: false
    end
  end
end
