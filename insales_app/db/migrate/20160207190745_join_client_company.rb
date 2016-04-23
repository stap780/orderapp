class JoinClientCompany < ActiveRecord::Migration
  def up
  	create_table :join_client_companies do |t|
		t.integer :client_id
		t.integer :company_id
    end
	
	drop_table :clients_companies
  end
end
