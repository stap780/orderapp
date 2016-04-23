class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.string :fulltitle
      t.string :uraddress
      t.string :factaddress
      t.integer :inn
      t.integer :kpp
      t.integer :ogrn
      t.integer :okpo
      t.integer :bik
      t.string :banktitle
      t.integer :bankaccount
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
