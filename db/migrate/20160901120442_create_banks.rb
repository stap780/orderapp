class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.integer :number
      t.string :type
      t.decimal :sum
      t.string :description
      t.date :date
      t.integer :payer_id
      t.integer :receiver_id
      t.integer :invoice_id

      t.timestamps null: false
    end
  end
end
