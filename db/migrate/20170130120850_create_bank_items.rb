class CreateBankItems < ActiveRecord::Migration
  def change
    create_table :bank_items do |t|
      t.references :bank, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true
      t.references :purchase_invoice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
