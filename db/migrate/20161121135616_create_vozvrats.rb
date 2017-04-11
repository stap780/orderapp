class CreateVozvrats < ActiveRecord::Migration
  def change
    create_table :vozvrats do |t|
      t.integer :number
      t.datetime :date
      t.integer :invoice_list_id

      t.timestamps null: false
    end
  end
end
