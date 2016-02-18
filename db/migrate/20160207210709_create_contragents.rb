class CreateContragents < ActiveRecord::Migration
  def up
    create_table :contragents do |t|
		t.integer :client_id
		t.integer :company_id
        t.timestamps null: false
    end
    drop_table :join_client_companies
  end
end
